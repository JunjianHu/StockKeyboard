//
//  SRStockSysKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

enum KeyPopType {
    case Normal
    case Left
    case Right
}

let kCharKeys = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]


class SRStockSysKeyboard: UIView {
    
    var  delegate : SRStockKeyboardDelegate?
    
    var keyPop : UIImageView?
    
    @IBOutlet var charButtons: [SRStockSysKeyButton]!
    
    class func sharedSysKeyboard()->SRStockSysKeyboard?{
        struct Singleton{
            static var onceToken : dispatch_once_t = 0
            static var instance : SRStockSysKeyboard?
        }
        dispatch_once(&Singleton.onceToken) { 
            let bundle = NSBundle.mainBundle()
            var views = bundle.loadNibNamed("SRStockSysKeyboard", owner: self, options: nil)
            if views.count > 0 {
                Singleton.instance = views[0] as? SRStockSysKeyboard
            }
        }
        
        return Singleton.instance
    }
    
    
    @IBAction func characterPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.keyDidPressed(kCharKeys[sender.tag])
        }
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.clearDidPress()
        }
    }
    
    @IBAction func spacePressed(sender: AnyObject) {
        if delegate != nil {
//            delegate?.keyDidPressed()
        }
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.deleteDidPressed()
        }
    }

    @IBAction func changeKeyboardPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.changeKeyboard()
        }
    }
    
    @IBAction func searchPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.searchDidPressed()
        }
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.touchOnButton(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        self.touchOnButton(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
    }
    
    
    func touchOnButton(touches: Set<UITouch>) {
        let touch = touches.first
        let point = touch?.locationInView(self)
        var button: UIButton?
        for tmpButton in charButtons {
            if tmpButton.frame.contains(point!) {
                button = tmpButton
                break
            }
        }
        if button == nil {
            return
        }
        self.addPopupToButton(button)
    }
    
    func addPopupToButton(button : UIButton?) {
        if keyPop?.tag == button?.tag {
            return
        }
        keyPop?.removeFromSuperview()
        keyPop = nil
        
        let textLabel = UILabel()
        
        if button?.tag == 0 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Right, withRect:button?.frame)
        }else if button?.tag == 9 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Left, withRect:button?.frame)
        }else {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Normal, withRect:button?.frame)
        }
        
        textLabel.text = kCharKeys[(button?.tag)!]
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.font = UIFont.systemFontOfSize(44)
        
        keyPop?.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(1.0).CGColor
        keyPop?.layer.shadowOffset = CGSizeMake(0, 3.0)
        keyPop?.layer.shadowOpacity = 1
        keyPop?.layer.shadowRadius = 5.0
        keyPop?.clipsToBounds = true
        
        keyPop?.addSubview(textLabel)
        keyPop?.tag = 1
        button?.addSubview(keyPop!)
    }
    
    func createKeyPopImageWithType(type:KeyPopType, withRect rect:CGRect?) -> UIImageView {
        
        let path = CGPathCreateMutable()
        var point = CGPointZero
       
        let radius: CGFloat = 5.0
        let topWith : CGFloat = (rect?.size.width)! * 1.3
        let upperHeight : CGFloat = 56.0
        let lowerHeight : CGFloat = 37.0
        
        point.x += radius
        CGPathMoveToPoint(path, nil, point.x, point.y)
        point.x += topWith
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.y += radius
        CGPathAddArcToPoint(path, nil, point.x, point.y, point.x + radius, point.y, CGFloat(M_PI_4))
        point.x += radius
        point.y += upperHeight
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.x += topWith
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.x += topWith
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        
        point.x = radius
        point.y = 0
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        
        let imageSize = CGSizeMake(topWith + radius * 2, upperHeight + radius * 2 + lowerHeight)
        
        UIGraphicsBeginImageContext(imageSize)
        let context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, path)
        let imageRef = CGBitmapContextCreateImage(context)
        let imageView = UIImageView(image: UIImage(CGImage: imageRef!))
        imageView.frame = CGRectMake(((rect?.size.width)! - imageSize.width) / 2, (rect?.height)! - imageSize.height, imageSize.width, imageSize.height)
        return imageView
    }
}
