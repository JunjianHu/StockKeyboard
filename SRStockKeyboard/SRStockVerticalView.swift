//
//  SRStockVerticalView.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/5/3.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

@IBDesignable
class SRStockVerticalView: UIView {

    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    
    
}
