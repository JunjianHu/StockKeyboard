//
//  SRStockSysKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

enum KeyPopType : CGFloat {
    case left = 0
    case normal = 1
    case right = 2
}

let kCharKeys = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]


class SRStockSysKeyboard: UIView {
    
    class func sharedStockSysKeyboard() -> SRStockSysKeyboard {
        var views = Bundle.main.loadNibNamed("SRStockSysKeyboard", owner: self, options: nil)
        let stockSysKeyboard = (views?[0] as! SRStockSysKeyboard)
        return stockSysKeyboard
    }
    
    var  delegate : SRStockKeyboardDelegate?
    
    var keyPop : UIImageView?
    
    @IBOutlet var charButtons: [SRStockSysKeyButton]!
    
    @IBAction func characterPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.keyDidPressed(key:kCharKeys[sender.tag])
        }
    }
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.clearDidPress()
        }
    }
    
    @IBAction func spacePressed(_ sender: AnyObject) {
        if delegate != nil {
//            delegate?.keyDidPressed()
        }
    }
    
    @IBAction func deletePressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.deleteDidPressed()
        }
    }

    @IBAction func changeKeyboardPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.changeKeyboard()
        }
    }
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.searchDidPressed()
        }
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.touchOnButton(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self.touchOnButton(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let button = self.buttonOnTouch(touches)
        if button != nil {
            self.characterPressed(button!)
        }
        self.removeKeyPop()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.removeKeyPop()
    }
    
    func removeKeyPop() {
        if keyPop != nil {
            keyPop?.removeFromSuperview()
            keyPop = nil
        }
    }
    
    func touchOnButton(_ touches: Set<UITouch>) {
        let button = self.buttonOnTouch(touches)
        if button == nil {
            return
        }
        self.addPopupToButton(button!)
    }
    
    func buttonOnTouch(_ touches: Set<UITouch>) -> UIButton? {
        let touch = touches.first
        let point = touch?.location(in: self)
        var button: UIButton?
        for tmpButton in charButtons {
            if tmpButton.frame.contains(point!) {
                button = tmpButton
                break
            }
        }
        return button
    }
    
    func addPopupToButton(_ button : UIButton) {
        
        if keyPop?.tag == button.tag {
            return
        }
        self .removeKeyPop()
        
        let textLabel = UILabel()
        
        if button.tag == 15 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.right, withRect:button.frame)
        }else if button.tag == 16 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.left, withRect:button.frame)
        }else {
            keyPop = self.createKeyPopImageWithType(KeyPopType.normal, withRect:button.frame)
        }
        
        textLabel.text = kCharKeys[button.tag]
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.clear
        textLabel.font = UIFont.systemFont(ofSize: 44)
        textLabel.frame = CGRect(x: 0, y: 0, width: (keyPop?.frame.size.width)!, height: 50)
        
        keyPop?.layer.shadowColor = UIColor.black.cgColor
        keyPop?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        keyPop?.layer.shadowOpacity = 1
        keyPop?.layer.shadowRadius = 2.0
        keyPop?.clipsToBounds = false
        
        keyPop?.addSubview(textLabel)
        keyPop?.tag = button.tag
        self.addSubview(keyPop!)
    }
    
    func createKeyPopImageWithType(_ type:KeyPopType, withRect rect:CGRect) -> UIImageView {
        let shapLayer = CAShapeLayer()
        let imageView = UIImageView()
        let popFrame = CGRect(x:rect.minX-CGFloat(10 * type.rawValue),
                              y:rect.minY-50,
                              width:rect.width + 20,
                              height:rect.height+50)
        let corner = 5.0 as CGFloat
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x:corner, y:corner))
        path.addArc(center: CGPoint(x:corner, y:corner),
                    radius: corner,
                    startAngle: CGFloat(-M_PI),
                    endAngle: CGFloat(-M_PI_2),
                    clockwise: false)
        path.addLine(to: CGPoint(x:popFrame.width-corner, y:0))
        path.addArc(center: CGPoint(x:popFrame.width - corner, y:corner),
                    radius: corner,
                    startAngle: CGFloat(-M_PI_2),
                    endAngle: CGFloat(0),
                    clockwise: false)
        if type != .right {
            path.addLine(to: CGPoint(x:popFrame.width, y:popFrame.height*0.55))
            path.addArc(center: CGPoint(x:popFrame.width - corner, y:popFrame.height*0.55 - corner),
                        radius: corner,
                        startAngle: CGFloat(0),
                        endAngle: CGFloat(M_PI_2),
                        clockwise: false)
            path.addLine(to: CGPoint(x:popFrame.width - 10 * type.rawValue, y:popFrame.height*0.55))
            path.addArc(center: CGPoint(x:popFrame.width  - CGFloat(10 * (2 - type.rawValue)) + 5,
                                        y:popFrame.height*0.55 + corner),
                        radius: corner,
                        startAngle: CGFloat(M_PI_2 * 3),
                        endAngle: CGFloat(M_PI),
                        clockwise: true)
            
        }
        path.addLine(to: CGPoint(x:popFrame.width  - 10 * (2 - type.rawValue), y:popFrame.height-corner))
        path.addArc(center: CGPoint(x:popFrame.width - 10 * (2 - type.rawValue) - corner,
                                    y:popFrame.height - corner),
                    radius: corner,
                    startAngle: CGFloat(0),
                    endAngle: CGFloat(M_PI_2),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x:(10 * type.rawValue) + corner, y:popFrame.height))
        path.addArc(center: CGPoint(x:(10 * type.rawValue) + corner, y:popFrame.height - corner),
                    radius: corner,
                    startAngle: CGFloat(M_PI_2),
                    endAngle: CGFloat(M_PI),
                    clockwise: false)
        if type != .left {
            path.addLine(to: CGPoint(x:(10 * type.rawValue), y:popFrame.height*0.55))
            path.addArc(center: CGPoint(x:(10 * type.rawValue) - corner, y:popFrame.height*0.55 + corner),
                        radius: corner,
                        startAngle: CGFloat(0),
                        endAngle: CGFloat(M_PI_2 * 3),
                        clockwise: true)
            path.addLine(to: CGPoint(x:0, y:popFrame.height*0.55))
            path.addArc(center: CGPoint(x:corner, y:popFrame.height*0.55 - corner),
                        radius: corner,
                        startAngle: CGFloat(M_PI_2),
                        endAngle: CGFloat(M_PI),
                        clockwise: false)
        }
        path.addLine(to: CGPoint(x:0, y:corner))
        shapLayer.path = path
        
        imageView.frame = popFrame
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x:0, y:0, width:popFrame.width, height:popFrame.height)
        gradient.colors=[UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        gradient.locations=[0.0, 0.618, 1]
        gradient.startPoint = CGPoint(x:0.5, y:0)
        gradient.endPoint = CGPoint(x:0.5, y:1)

        imageView.layer.addSublayer(gradient)
        gradient.mask = shapLayer
        return imageView
    }
}
