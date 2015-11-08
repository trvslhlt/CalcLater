//
//  CalcLaterEngine.swift
//  CalcLater
//
//  Created by trvslhlt on 11/6/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import Foundation

struct CalcLaterEngine: ExpressionEngine {
    
    static func computeExpressionValue(symbols: [CalcLaterSymbol]) -> String {
        guard let last = symbols.last else { return "" }
        
        if CalcLaterSymbol.lastIsDigit(symbols) || CalcLaterSymbol.lastIsDecimal(symbols) {
            let tailDigitSequence = CalcLaterSymbol.tailDigitSequence(symbols)
            return tailDigitSequence.reduce(""){ $0 + "\($1.rawValue)" }
        } else if CalcLaterSymbol.arithmeticOperatorSet.contains(last) {
            return computeExpressionValue(Array(symbols.dropLast()))
        }
        return "TEST"
    }
    
}