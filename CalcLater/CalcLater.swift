//
//  CalcLater.swift
//  CalcLater
//
//  Created by trvslhlt on 10/31/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import UIKit

class CalcLater {
    
    static let singleton = CalcLater()
    private init() {}
    var outputUpdated: (String -> ())?
    var isInClearAllMode: Bool { get { return currentInput == CalcLater.initialInputValue } }
    private var liveOperator: String?
    private var isInInputHeadMode: Bool { return liveOperator == nil }
    private var isAwaitingInputTail: Bool { return !isInInputHeadMode && inputTail == CalcLater.initialInputValue }
    private static let initialInputValue = "0"
    private var inputHead = CalcLater.initialInputValue
    private var inputTail = CalcLater.initialInputValue
    private var currentInput: String {
        get { return isInInputHeadMode ? inputHead : inputTail }
        set {
            if isInInputHeadMode { inputHead = newValue }
            else { inputTail = newValue
            }
        }
    }
    
    func valueInput(value: String) {
        if Double(value) != nil ||
            value == CalcLaterConstants.decimalSign ||
            value == CalcLaterConstants.negateSign ||
            value == CalcLaterConstants.clearSign ||
            value == CalcLaterConstants.clearAllSign {
            manipulationInput(value)
        } else {
            computationInput(value)
        }
    }
    
    func manipulationInput(input: String) {
        defer {
            let output = isAwaitingInputTail ? inputHead : currentInput
            outputUpdated?(output)
        }
        guard Double(input) == nil else {
            digitInput(input)
            return
        }

        switch input {
        case CalcLaterConstants.decimalSign: decimalInput()
        case CalcLaterConstants.negateSign: negateInput()
        case CalcLaterConstants.clearSign: clearInput()
        case CalcLaterConstants.clearAllSign: clearAllInput()
        default: ()
        }
    }
    
    func computationInput(input: String) {
        switch input {
        case CalcLaterConstants.plusSign: plusInput()
        case CalcLaterConstants.minusSign: minusInput()
        case CalcLaterConstants.multiplySign: multiplyInput()
        case CalcLaterConstants.divideSign: divideInput()
        case CalcLaterConstants.percentSign: percentInput()
        case CalcLaterConstants.equalsSign: equalsInput()
        default:()
        }
        
        outputUpdated?(inputHead)
    }
    
    func computeToInputHead() {
        guard let liveOperator = liveOperator else {
            print("assumption of live operator is not sound")
            return
        }
        
        let valueHead = inputToDouble(inputHead)
        let valueTail = inputToDouble(inputTail)
        
        switch liveOperator {
        case CalcLaterConstants.plusSign: inputHead = "\(valueHead + valueTail)"
        default: ()
        }
        
        inputTail = CalcLater.initialInputValue
    }
    
    func plusInput() {
        // +            not possible
        // 0 +          √
        // 1. +         √
        // 2.3 +        √
        // 2 - +        √
        // 2 * 3 +      √
        guard !(isInInputHeadMode && currentInput == CalcLater.initialInputValue) else { return }
        if !isInInputHeadMode || !isAwaitingInputTail { computeToInputHead() }
        liveOperator = CalcLaterConstants.plusSign
    }
    func multiplyInput() {}
    func divideInput() {}
    func minusInput() {}
    func percentInput() {}
    func equalsInput() {}
    
    func digitInput(digit: String) {
        currentInput = currentInput == CalcLater.initialInputValue ? digit : currentInput + digit
    }
    
    func decimalInput() {
        currentInput = currentInput.rangeOfString(".") == nil ? currentInput + CalcLaterConstants.decimalSign : currentInput
    }
    
    func clearInput() {
        currentInput = CalcLater.initialInputValue
    }
    
    func clearAllInput() {
        inputHead = CalcLater.initialInputValue
        inputTail = CalcLater.initialInputValue
        liveOperator = nil
    }
    
    func negateInput() {
        guard currentInput != CalcLater.initialInputValue else { return }
        if let firstCharacter = currentInput.characters.first {
            currentInput = firstCharacter == Character(CalcLaterConstants.negativeSign) ?
                String(currentInput.characters.dropFirst()) :
                CalcLaterConstants.negativeSign + currentInput
        }
    }
    
    func inputToDouble(input: String) -> Double {
        return Double(input) ?? 0
    }

}
