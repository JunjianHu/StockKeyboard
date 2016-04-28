//
//  SRStockSysKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

class SRStockSysKeyboard: UIView {
    class func sharedSysKeyboard()->UIView?{
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
    }
    
    
    @IBAction func clearPressed(sender: AnyObject) {
    }
    
    @IBAction func spacePressed(sender: AnyObject) {
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
    }

    @IBAction func changeKeyboardPressed(sender: AnyObject) {
    }
    
    @IBAction func searchPressed(sender: AnyObject) {
    }
    
}
