//
//  ViewController.swift
//  Calculator
//
//  Created by Malcolm Macleod on 15/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTypingNumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) -> Void{
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInMiddleOfTypingNumber = true
        }

        println("digit = \(digit)")
    }
}

