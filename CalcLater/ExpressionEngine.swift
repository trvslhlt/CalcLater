//
//  ExpressionEngine.swift
//  CalcLater
//
//  Created by trvslhlt on 11/4/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import Foundation

protocol ExpressionEngine {
    static func computeExpressionValue(symbols: [CalcLaterSymbol]) -> (symbols: [CalcLaterSymbol], computedOutput: String)
}