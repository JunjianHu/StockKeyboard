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
        let button = self.buttonOnTouch(touches)
        if button != nil {
            self.characterPressed(button!)
        }
        self.removeKeyPop()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        self.removeKeyPop()
    }
    
    func removeKeyPop() {
        if keyPop != nil {
            keyPop?.removeFromSuperview()
            keyPop = nil
        }
    }
    
    func touchOnButton(touches: Set<UITouch>) {
        let button = self.buttonOnTouch(touches)
        if button == nil {
            return
        }
        self.addPopupToButton(button)
    }
    
    func buttonOnTouch(touches: Set<UITouch>) -> UIButton? {
        let touch = touches.first
        let point = touch?.locationInView(self)
        var button: UIButton?
        for tmpButton in charButtons {
            if tmpButton.frame.contains(point!) {
                button = tmpButton
                break
            }
        }
        return button
    }
    
    func addPopupToButton(button : UIButton?) {
        if keyPop?.tag == button?.tag {
            return
        }
        self .removeKeyPop()
        
        let textLabel = UILabel()
        
        if button?.tag == 15 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Right, withRect:button?.frame)
        }else if button?.tag == 16 {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Left, withRect:button?.frame)
        }else {
            keyPop = self.createKeyPopImageWithType(KeyPopType.Normal, withRect:button?.frame)
        }
        
        textLabel.text = kCharKeys[(button?.tag)!]
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.font = UIFont.systemFontOfSize(44)
        textLabel.frame = CGRectMake(0, 0, (keyPop?.frame.size.width)!, 70)
        
//        keyPop?.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(1.0).CGColor
//        keyPop?.layer.shadowOffset = CGSizeMake(0, 2.0)
//        keyPop?.layer.shadowOpacity = 1
//        keyPop?.layer.shadowRadius = 1.0
//        keyPop?.clipsToBounds = true
        
        keyPop?.addSubview(textLabel)
        keyPop?.tag = 1
        button?.addSubview(keyPop!)
    }
    
    func createKeyPopImageWithType(type:KeyPopType, withRect rect:CGRect?) -> UIImageView {
        let path = CGPathCreateMutable()
        var point = CGPointZero
        
        let radius: CGFloat = 10.0
        let topWith : CGFloat = (rect?.size.width)! * 1.4
        let upperHeight : CGFloat = 46.0
        let lowerHeight : CGFloat = 50.0
        
        point.y += radius
        CGPathMoveToPoint(path, nil, point.x, point.y)
        CGPathAddArcToPoint(path, nil, point.x, point.y, point.x, point.y-radius, radius)
        point.x += topWith
        CGPathAddArcToPoint(path, nil, point.x, point.y, point.x+radius, point.y+radius, radius)
        point.y += upperHeight
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        switch type {
        case .Normal:
            point.x -= ((rect?.size.width)! * 0.2)
        case .Left:
            point.x -= (rect?.size.width)! * 0.4
        default:
            break
        }
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.y += lowerHeight
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.x -= (rect?.size.width)!
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.y -= lowerHeight
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        switch type {
        case .Normal:
            point.x -= ((rect?.size.width)! * 0.2)
        case .Right:
            point.x -= (rect?.size.width)! * 0.4
        default:
            break
        }
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        point.y -= upperHeight
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        
        let imageSize = CGSizeMake(topWith, upperHeight + lowerHeight)

        
        UIGraphicsBeginImageContext(imageSize)
        let context = UIGraphicsGetCurrentContext()
        // 创建色彩空间对象
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        // 创建起点颜色
        let beginColor = CGColorCreate(colorSpaceRef, [0.99, 0.99, 0.99, 1.0]);
        
        // 创建终点颜色
        let endColor = CGColorCreate(colorSpaceRef, [0.95, 0.95, 0.95, 1.0]);
        let colors: [CGColor] = [beginColor!, endColor!]
        let colorsPointer = UnsafeMutablePointer<UnsafePointer<Void>>(colors)
        // 创建颜色数组
        let colorArray = CFArrayCreate(kCFAllocatorDefault, colorsPointer, 2, nil);
        
        // 创建渐变对象
        let gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, [
            0.0,       // 对应起点颜色位置
            1.0        // 对应终点颜色位置
            ]);
        
        CGContextSetLineWidth(context, 2.0)
        CGContextAddPath(context, path)
        CGContextClip(context)
        CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0, 0), CGPointMake(0, imageSize.height), CGGradientDrawingOptions.DrawsBeforeStartLocation)
        CGContextFillPath(context)
        let imageRef = CGBitmapContextCreateImage(context)
        UIGraphicsEndImageContext()
        let imageview = UIImageView(image: UIImage(CGImage: imageRef!))
        switch type {
        case .Normal:
            imageview.frame =  CGRectMake(((rect?.size.width)! - imageSize.width) / 2, (rect?.height)! - imageSize.height, imageSize.width, imageSize.height)
        case .Right:
            imageview.frame =  CGRectMake((rect?.size.width)! - imageSize.width, (rect?.height)! - imageSize.height, imageSize.width, imageSize.height)
        case .Left:
            imageview.frame =  CGRectMake(0, (rect?.height)! - imageSize.height, imageSize.width, imageSize.height)
        }
        
        return imageview
    }
}
