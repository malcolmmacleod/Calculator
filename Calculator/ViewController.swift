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

    @IBOutlet weak var history: UILabel!
    
    var userIsInMiddleOfTypingNumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) -> Void{
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingNumber {
            if digit == "." {
                if let current = display.text {
                    let found = current.rangeOfString(".")
                    if found == nil {
                        display.text = display.text! + digit
                    }
                }
            } else {
                display.text = display.text! + digit
            }
            
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            
            userIsInMiddleOfTypingNumber = true
        }

        println("digit = \(digit)")
    }
    
    var brain = CalculatorBrain()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingNumber = false

        self.history.text = self.history.text! + " " + "\(displayValue!)"
        
        if let result = brain.pushOperand(displayValue!) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func backspace() {
        if let current = display.text {
            if count(current) > 1 {
                display.text = dropLast(current)
            } else {
                display.text = "0"
            }
        }
    }
    
    @IBAction func clear() {
        userIsInMiddleOfTypingNumber = false
        brain.clear()
        display.text = "0"
        history.text = ""
    }
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
        }
        set {
            if let aval = newValue {
                display.text = "\(aval)"
            } else {
                display.text = ""
            }
            userIsInMiddleOfTypingNumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
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
        
        self.history.text = self.history.text! + " " + "\(operation)="
    }
    
    @IBAction func negate(sender: UIButton) {
        if userIsInMiddleOfTypingNumber {
            if let found = display.text!.rangeOfString("-") {
                display.text!.removeRange(found)
            } else {
                display.text = "-" + display.text!
            }
        } else {
            operate(sender)
        }
    }
    
    func performPiOperation() -> Void {
        displayValue = M_PI
        enter()
    }
}

