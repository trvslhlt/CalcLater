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
    
    // MARK: ComputedState
    private var inputSequenceContainsArithmeticOperator: Bool {
        return inputSequence.reduce(false) { CalcLaterSymbol.arithmeticOperatorSet().contains($1) || $0 }
    }
    private var inputLastIsDecimal: Bool {
        if let last = inputSequence.last { return last == .DecimalSign }
        return false
    }
    
    private var inputLastIsDigit: Bool {
        if let tail = inputSequence.last { return CalcLaterSymbol.isDigit(tail) }
        return false
    }

    var clearIsValidInput: Bool {
        return inputLastIsDecimal || inputLastIsDigit
    }
    
    var inputLastIsEquals: Bool {
        if let last = inputSequence.last { return last == .EqualsSign }
        return false
    }
    
    var inputTailDigitSequenceContainsDecimal: Bool {
        return CalcLater.symbolSequenceTailDigitSequenceContainsDecimal(inputSequence)
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
        
        if (CalcLaterSymbol.isDigit(lastSymbol) || inputLastIsEquals || inputLastIsDecimal) && inputSequenceContainsArithmeticOperator {
            if inputLastIsDecimal { inputSequence.removeLast() }
            inputSequence.append(.EqualsSign)
        }
    }

    private func inputClearAll() {
        inputSequence = []
    }

    private func inputClear() {
        if inputLastIsDigit || inputLastIsDecimal {
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
        if inputTailDigitSequenceContainsDecimal {
            return
        } else if !inputLastIsDigit {
            inputSequence.append(.Zero)
        }
        inputSequence.append(.DecimalSign)
    }

    private func inputDigit(symbol: CalcLaterSymbol) {
        inputSequence.append(symbol)
    }
    
    //MARK: Utility
    static func symbolSequenceTailDigitSequenceContainsDecimal(symbolSequence: [CalcLaterSymbol]) -> Bool {
        if let last = symbolSequence.last {
            if last == .DecimalSign {
                return true
            } else if CalcLaterSymbol.isDigit(last) {
                return symbolSequenceTailDigitSequenceContainsDecimal(Array(symbolSequence.dropLast()))
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}