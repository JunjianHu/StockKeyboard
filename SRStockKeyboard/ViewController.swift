//
//  ViewController.swift
//  SRStockKeyboard
//
//  Created by HuJunjian on 16/4/28.
//  Copyright © 2016年 StockRadar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.inputView = SRStockKeyboard.sharedInstance()
        
//        let button = UIButton(type:.Custom)
//        button.frame = CGRectMake(30, 20, 300, 80)
//        button.setTitle("dengl", forState: UIControlState.Normal)
//        button.backgroundColor = UIColor.blueColor()
//        button.layer.cornerRadius = 10
//        button.layer.shadowOffset = CGSizeMake(2, 2)
//        button.layer.shadowOpacity = 0.8
//        button.layer.shadowColor = UIColor.blackColor().CGColor
//        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

