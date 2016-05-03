//
//  SRStockNumKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

let kNumKeys = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "600", "601", "000", "002", "300"]

class SRStockNumKeyboard: UIView {
    
    var  delegate : SRStockKeyboardDelegate?
    
    class func sharedNumKeyboard()->SRStockNumKeyboard?{
        struct Singleton{
            static var onceToken : dispatch_once_t = 0
            static var instance : SRStockNumKeyboard?
        }
        dispatch_once(&Singleton.onceToken) {
            let bundle = NSBundle.mainBundle()
            var views = bundle.loadNibNamed("SRStockNumKeyboard", owner: self, options: nil)
            if views.count > 0 {
                Singleton.instance = views[0] as? SRStockNumKeyboard
            }
        }
        
        return Singleton.instance
    }

    @IBAction func keyDidPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.keyDidPressed(kNumKeys[sender.tag])
        }
    }

    @IBAction func deleteDidPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.deleteDidPressed()
        }
    }
    
    
    @IBAction func hideDidPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.hideDidPressed()
        }
    }
    
    @IBAction func clearDidPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.clearDidPress()
        }
    }
    
    @IBAction func changeKeyboard(sender: AnyObject) {
        if delegate != nil {
            delegate?.changeKeyboard()
        }
    }
    
    @IBAction func okDidPressed(sender: AnyObject) {
        if delegate != nil {
            delegate?.searchDidPressed()
        }
    }
}
