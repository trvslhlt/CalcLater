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
    
}

extension CalcLaterSymbol {
    static let arithmeticOperatorSet: Set<CalcLaterSymbol> = [
            .PlusSign,
            .MinusSign,
            .MultiplySign,
            .DivideSign]
    
    func isDigit() -> Bool {
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
        return digitSet.contains(self)
    }
    
    static func lastIsDigit(sequence: [CalcLaterSymbol]) -> Bool {
        if let last = sequence.last { return last.isDigit() }
        return false
    }
    
    static func lastIsDecimal(sequence: [CalcLaterSymbol]) -> Bool {
        if let last = sequence.last { return last == .DecimalSign }
        return false
    }
    
    static func lastIsEquals(sequence: [CalcLaterSymbol]) -> Bool {
        if let last = sequence.last { return last == .EqualsSign }
        return false
    }
    
    static func containsArithmeticOperator(sequence: [CalcLaterSymbol]) -> Bool {
        return sequence.reduce(false) { CalcLaterSymbol.arithmeticOperatorSet.contains($1) || $0 }
    }
    
    static func tailDigitSequenceContainsDecimal(sequence: [CalcLaterSymbol]) -> Bool {
        if let last = sequence.last {
            if last == .DecimalSign {
                return true
            } else if last.isDigit() {
                return tailDigitSequenceContainsDecimal(Array(sequence.dropLast()))
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func tailDigitSequence(sequence: [CalcLaterSymbol]) -> [CalcLaterSymbol] {
        guard let last = sequence.last else { return [] }
        if last.isDigit() || last == .DecimalSign {
            return tailDigitSequence(Array(sequence.dropLast())) + [last]
        } else {
            return []
        }
    }
}


//TODO: Attempt at extending [CalcLaterSymbol]. This would be better than the current solution

//extension Array where Element: CalcLaterSymbol {
//    func lastIsDigit() -> Bool {
//        if let last = self.last { return isDigit(last) }
//    }
//    
//    func lastIsDecimal() -> Bool {
//        if let last = self.last { return last == .DecimalSign }
//    }
//    
//    func lastIsEquals() -> Bool {
//        if let last = self.last { return last == .EqualsSign }
//    }
//    
//    func containsArithmeticOperator() -> Bool {
//        return sequence.reduce(false) { CalcLaterSymbol.arithmeticOperatorSet().contains($1) || $0 }
//    }
//    
//    func tailDigitSequenceContainsDecimal() -> Bool {
//        if let last = self.last {
//            if last == .DecimalSign {
//                return true
//            } else if CalcLaterSymbol.isDigit(last) {
//                return symbolSequenceTailDigitSequenceContainsDecimal(Array(self.dropLast()))
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//}



