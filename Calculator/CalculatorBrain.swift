//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Malcolm Macleod on 16/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import Foundation

public class CalculatorBrain
{
    private enum Op : Printable {  // enum can have computed properties and methods
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()  // array of Op
    private var knownOps = [String: Op]()  // dictionary of string and op
    
    public init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })  // ordering of params is important here so func is specified as closure
        learnOp(Op.BinaryOperation("-") { $1 - $0 } ) // ordering of params is important here so func is specified as closure
        learnOp(Op.UnaryOperation("√", sqrt))
    }
    
    public var program: AnyObject {  // guaranteed to be prop list
        get {
            return opStack.map { $0.description }
        }
        set {
            if let opSymbols = newValue as? [String] {
                var newOpStack = [Op]()
                
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    }
                }
                
                opStack = newOpStack
            }
        }
    }
    
    public func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    public func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    public func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {  // we are passing an array as a struct - structs passed by value.  This means ops is going to be copied when it is passed in
        if !ops.isEmpty {
            var remainingOps = ops  // create a mutable copy to return
            let op = remainingOps.removeLast()
            
            switch(op) {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let op1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let op2 = op2Evaluation.result {
                        return (operation(op1, op2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
    }
}
