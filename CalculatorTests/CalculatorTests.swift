//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Malcolm Macleod on 15/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit
import XCTest
import Calculator

class CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddTwoNumbers () {
        var brain = CalculatorBrain()
        
        brain.pushOperand(2)
        brain.pushOperand(4)
        brain.performOperation("+")
        var result = brain.evaluate()
        
        assert(result == 6, "Expected result to equal 6")
    }
    
    func testMultiplyTwoNumbers () {
        var brain = CalculatorBrain()
        
        brain.pushOperand(2)
        brain.pushOperand(4)
        brain.performOperation("×")
        var result = brain.evaluate()
        
        assert(result == 8, "Expected result to equal 8")
    }
    
    
    func testSubtractTwoNumbers () {
        var brain = CalculatorBrain()
        
        brain.pushOperand(4)
        brain.pushOperand(2)
        brain.performOperation("-")
        var result = brain.evaluate()
        
        assert(result == 2, "Expected result to equal 2")
    }
    
    func testDivideTwoNumbers () {
        var brain = CalculatorBrain()
        
        brain.pushOperand(4)
        brain.pushOperand(2)
        brain.performOperation("÷")
        var result = brain.evaluate()
        
        assert(result == 2, "Expected result to equal 2")
    }
    
    func testSqrtOneNumbers () {
        var brain = CalculatorBrain()
        
        brain.pushOperand(4)
        brain.performOperation("√")
        var result = brain.evaluate()
        
        assert(result == 2, "Expected result to equal 2")
    }

}
