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
        learnOp(Op.UnaryOperation("sin") { sin(($0 * M_PI) / 180) } )
        learnOp(Op.UnaryOperation("cos") { cos(($0 * M_PI) / 180) } )
        learnOp(Op.UnaryOperation("+/-") { self.negate($0) } )
        learnOp(Op.UnaryOperation("pi") { self.pi($0) } )
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
    
    public func clear() {
        opStack.removeAll(keepCapacity: false)
    }
    
    private func negate (operand: Double) -> Double {
        let negative = -operand
        return negative
    }
    
    private func pi (operand: Double) -> Double {
        return M_PI
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
