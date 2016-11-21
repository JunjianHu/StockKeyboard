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
    let charKeyboard = SRStockSysKeyboard.sharedStockSysKeyboard()
    let numKeyboard = SRStockNumKeyboard.sharedNumKeyboard()
    
    static let stockKeyboard : SRStockKeyboard = {
        let window = UIApplication.shared.windows[0]
        let windowFrame = window.bounds
        let keyboard = SRStockKeyboard(frame: CGRect(x:0, y:(windowFrame.size.height)-216, width:(windowFrame.size.width), height:216))
        return keyboard;
    }()
    
    class func sharedInstance() -> SRStockKeyboard? {
        return stockKeyboard
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        charKeyboard.frame = self.bounds
        numKeyboard.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        charKeyboard.delegate = self
        charKeyboard.isHidden = true
        self.addSubview(charKeyboard)
        
        
        numKeyboard.delegate = self
        self.addSubview(numKeyboard)

        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(notification:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
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
        targetTextField!.text = targetTextField!.text?.appending(key)
    }
    
    func changeKeyboard() {
        numKeyboard.isHidden = (charKeyboard.isHidden)
        charKeyboard.isHidden = !(charKeyboard.isHidden)
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
        let text = targetTextField?.text
        if text == nil || (text?.isEmpty)!{
            return
        }
        let index = text?.index((text?.endIndex)!, offsetBy: -1)
        targetTextField?.text = text?.substring(to: index!)
    }
    
    func hideDidPressed() {
        if targetTextField == nil {
            return
        }
        targetTextField?.resignFirstResponder()
    }
}
