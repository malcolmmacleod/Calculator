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
    @IBOutlet weak var display: UILabel! // initialised by UI initialisation, so it is an implicitly unwrapped optional.  It is always automatically unwrapped.  This property is initialised very early and is always set.
    
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
    
    var brain = CalculatorBrain()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInMiddleOfTypingNumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {

        if userIsInMiddleOfTypingNumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
}

