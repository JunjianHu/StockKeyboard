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
    
    class func sharedNumKeyboard() ->SRStockNumKeyboard{
        var views = Bundle.main.loadNibNamed("SRStockNumKeyboard", owner: self, options: nil)
        let numKeyboard = (views?[0] as! SRStockNumKeyboard)
        return numKeyboard
    }
    
    @IBAction func keyDidPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.keyDidPressed(key:kNumKeys[sender.tag])
        }
    }

    @IBAction func deleteDidPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.deleteDidPressed()
        }
    }
    
    
    @IBAction func hideDidPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.hideDidPressed()
        }
    }
    
    @IBAction func clearDidPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.clearDidPress()
        }
    }
    
    @IBAction func changeKeyboard(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.changeKeyboard()
        }
    }
    
    @IBAction func okDidPressed(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.searchDidPressed()
        }
    }
}
