//
//  CalcLaterEngine.swift
//  CalcLater
//
//  Created by trvslhlt on 11/6/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import Foundation

struct CalcLaterEngine: ExpressionEngine {
    
    static func computeExpressionValue(symbols: [CalcLaterSymbol]) -> (symbols: [CalcLaterSymbol], computedOutput: String) {
        return (symbols: symbols, computedOutput: "TEST")
    }
    
}