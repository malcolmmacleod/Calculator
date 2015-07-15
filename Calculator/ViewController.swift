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
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        self.history.text = self.history.text! + "," + "\(displayValue)"
    }
    
    @IBAction func backspace() {
    }
    
    @IBAction func clear() {
        userIsInMiddleOfTypingNumber = false
        operandStack.removeAll(keepCapacity: false)
        display.text = "0"
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
        let operation = sender.currentTitle!
        
        if userIsInMiddleOfTypingNumber {
            enter()
        }
        
        self.history.text = self.history.text! + "," + "\(operation)"
        
        switch operation {
            case "×":
                performOperation { $0 * $1 }
            case "-":
                performOperation { $1 - $0 }
            case "+":
                performOperation { $0 + $1 }
            case "÷":
                performOperation { $1 / $0 }
            case "√":
                performUnaryOperation { sqrt($0) }
            case "sin" :
                performUnaryOperation { sin(($0 * M_PI) / 180) }
            case "cos":
                performUnaryOperation { cos(($0 * M_PI) / 180) }
            case "pi":
                performPiOperation()
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performUnaryOperation(op: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = op(operandStack.removeLast())
            enter()
        }
    }
    
    func performPiOperation() -> Void {
        displayValue = M_PI
        enter()
    }
}

