//
//  CalcLaterConstants.swift
//  CalcLater
//
//  Created by trvslhlt on 10/31/15.
//  Copyright © 2015 travis holt. All rights reserved.
//
import Foundation

struct CalcLaterConstants {
    private init() {}
    static let plusSign = "+"
    static let minusSign = "-"
    static let multiplySign = "x"
    static let divideSign = "/"
    static let percentSign = "%"
    static let equalsSign = "="
    static let clearSign = "c"
    static let clearAllSign = "ac"
    static let decimalSign = "."
    static let negateSign = "+/-"
    static let initialDisplay = "0"
    static let negativeSign = "-"
    static var arithmeticSet: Set<String> = [
        CalcLaterConstants.plusSign,
        CalcLaterConstants.minusSign,
        CalcLaterConstants.multiplySign,
        CalcLaterConstants.divideSign
    ]
}