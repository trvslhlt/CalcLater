//
//  CalcLaterSymbols.swift
//  CalcLater
//
//  Created by trvslhlt on 11/4/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import Foundation

enum CalcLaterSymbol: String {
    
    case Zero = "0"
    case One = "1"
    case Two = "2"
    case Three = "3"
    case Four = "4"
    case Five = "5"
    case Six = "6"
    case Seven = "7"
    case Eight = "8"
    case Nine = "9"
    
    case DecimalSign = "."
    
    case PlusSign = "+"
    case MinusSign = "-"
    case MultiplySign = "x"
    case DivideSign = "/"
    case PercentSign = "%"
    case EqualsSign = "="
    case ClearSign = "c"
    case ClearAllSign = "ac"
    case NegateSign = "+/-"
    case NegativeSign = "~"
    
    static func arithmeticOperatorSet() -> Set<CalcLaterSymbol> {
        return [
        .PlusSign,
        .MinusSign,
        .MultiplySign,
        .DivideSign]
    }
    
    static func isDigit(symbol: CalcLaterSymbol) -> Bool {
        let digitSet: Set<CalcLaterSymbol> = [
            .Zero,
            .One,
            .Two,
            .Three,
            .Four,
            .Five,
            .Six,
            .Seven,
            .Eight,
            .Nine,
        ]
        return digitSet.contains(symbol)
    }
    
}