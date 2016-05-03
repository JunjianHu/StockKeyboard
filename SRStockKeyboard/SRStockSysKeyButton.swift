//
//  SRStockSysKeyButton.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

@IBDesignable
class SRStockSysKeyButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.CGColor
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = 0.5
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSizeZero {
        didSet {
            layer.shadowOffset = shadowOffset;
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(0.8)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(1.0)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(1.0)
    }
    
}
