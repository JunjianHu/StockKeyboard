//
//  SRStockSysKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

let kCharKeys = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

class SRStockSysKeyboard: UIView {
    
    var  delegate : SRStockKeyboardDelegate?
    
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
    
}
