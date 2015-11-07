//
//  CalcLaterAlt.swift
//  CalcLater
//
//  Created by trvslhlt on 11/1/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import Foundation

// 4 + 2 * 2 + 10 / 10 * 5 = =
// interpret as...
// 4 + 2 * 2 + 10 / 10 * 5 * 5
// 4 + 4 + 10 / 10 * 5 * 5
// 4 + 4 + 1 * 5 * 5
// 4 + 4 + 5 * 5
// 4 + 4 + 25
// 8 + 25
// 33

// 4 + 3 = * 5 =
// 7 * 5 =
// 35

// 4 + 3 * 5 =
//

class CalcLater {
    
    //MARK: State
    static let sharedInstance = CalcLater()
    private var inputSequence = [CalcLaterSymbol]()
    private var expressionEngine = CalcLaterEngine()
    var computedOutput: String?

    var clearIsValidInput: Bool {
        return CalcLaterSymbol.lastIsDecimal(inputSequence) || CalcLaterSymbol.lastIsDigit(inputSequence)
    }

    //MARK: Input
    func input(symbol: CalcLaterSymbol) {
        // this function should only route input
        switch symbol {
        case .EqualsSign: inputEquals()
        case .ClearAllSign: inputClearAll()
        case .ClearSign: inputClear()
        case .PlusSign: inputPlus()
        case .MinusSign: inputMinus()
        case .MultiplySign: inputMultiply()
        case .DivideSign: inputDivide()
        case .DecimalSign: inputDecimal()
        default: inputDigit(symbol)
        }
        
        print(inputSequence.reduce("") { $0 + "\($1)"})
    }
    
    //MARK: Input validators + mutation
    private func inputEquals() {
        guard let lastSymbol = inputSequence.last else { return }
        
        if (lastSymbol.isDigit() ||
            CalcLaterSymbol.lastIsEquals(inputSequence) ||
            CalcLaterSymbol.lastIsDecimal(inputSequence)) &&
            CalcLaterSymbol.containsArithmeticOperator(inputSequence) {
            if CalcLaterSymbol.lastIsDecimal(inputSequence) { inputSequence.removeLast() }
            inputSequence.append(.EqualsSign)
        }
    }

    private func inputClearAll() {
        inputSequence = []
    }

    private func inputClear() {
        if CalcLaterSymbol.lastIsDigit(inputSequence) || CalcLaterSymbol.lastIsDecimal(inputSequence) {
            inputSequence.removeLast()
            inputClear()
        }
    }
    
    func inputPlus() {
        inputSequence.append(.PlusSign)
    }
    
    func inputMinus() {
        inputSequence.append(.MinusSign)
    }
    
    func inputMultiply() {
        inputSequence.append(.MultiplySign)
    }
    
    func inputDivide() {
        inputSequence.append(.DivideSign)
    }
    
    private func inputDecimal() {
        if CalcLaterSymbol.tailDigitSequenceContainsDecimal(inputSequence) {
            return
        } else if !CalcLaterSymbol.lastIsDigit(inputSequence) {
            inputSequence.append(.Zero)
        }
        inputSequence.append(.DecimalSign)
    }

    private func inputDigit(symbol: CalcLaterSymbol) {
        inputSequence.append(symbol)
    }
    
}