//
//  SRStockKeyboard.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/5/3.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

protocol SRStockKeyboardDelegate {
    func changeKeyboard()
    func keyDidPressed(key : String)
    func clearDidPress()
    func searchDidPressed()
    func deleteDidPressed()
    func hideDidPressed()
}


class SRStockKeyboard: UIView, SRStockKeyboardDelegate {

    var targetTextField : UITextField?
    let charKeyboard = SRStockSysKeyboard.sharedSysKeyboard()
    let numKeyboard = SRStockNumKeyboard.sharedNumKeyboard()
    
    class func sharedInstance() -> SRStockKeyboard? {
        struct Singleton {
            static var token : dispatch_once_t = 0
            static var keyboard : SRStockKeyboard?
        }
        dispatch_once(&Singleton.token) {
            let window = UIApplication.sharedApplication().windows[0]
            let windowFrame = window.bounds
            Singleton.keyboard = SRStockKeyboard(frame: CGRectMake(0, (windowFrame.size.height)-216, (windowFrame.size.width), 216))
        }
        return Singleton.keyboard
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        charKeyboard?.frame = self.bounds
        numKeyboard?.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        charKeyboard?.delegate = self
        charKeyboard?.hidden = true
        self.addSubview(charKeyboard!)
        
        
        numKeyboard?.delegate = self
        self.addSubview(numKeyboard!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: UITextFieldTextDidBeginEditingNotification, object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textViewDidBeginEditing(notification : NSNotification) {
        targetTextField = notification.object as? UITextField
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func keyDidPressed(key: String) {
        if targetTextField == nil {
            return
        }
        targetTextField!.text = targetTextField!.text?.stringByAppendingString(key)
    }
    
    func changeKeyboard() {
        numKeyboard?.hidden = (charKeyboard?.hidden)!
        charKeyboard?.hidden = !(charKeyboard?.hidden)!
    }
    
    func clearDidPress() {
        if targetTextField == nil {
            return
        }
        targetTextField!.text = ""
    }
    func searchDidPressed() {
        targetTextField?.resignFirstResponder()
    }
    
    func deleteDidPressed() {
        
    }
    
    func hideDidPressed() {
        if targetTextField == nil {
            return
        }
        targetTextField?.resignFirstResponder()
    }
}
