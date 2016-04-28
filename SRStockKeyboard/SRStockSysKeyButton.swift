//
//  SRStockSysKeyButton.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

class SRStockSysKeyButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.CGColor
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    @IBInspectable var shadowYOffset: CGFloat = 0 {
        didSet {
            var shadowSize = layer.shadowOffset;
            shadowSize.height = shadowYOffset;
            layer.shadowOffset = shadowSize;
        }
    }
    
    @IBInspectable var shadowXOffset: CGFloat = 0 {
        didSet {
            var shadowSize = layer.shadowOffset;
            shadowSize.width = shadowXOffset;
            layer.shadowOffset = shadowSize;
        }
    }
}
