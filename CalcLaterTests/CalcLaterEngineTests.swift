//
//  CalcLaterEngineTests.swift
//  CalcLater
//
//  Created by trvslhlt on 11/7/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import XCTest
@testable import CalcLater

// This class has no internal state. `setup()` and `tearDown()` unnecessary.
// All tests assume valid input sequences
class CalcLaterEngineTests: XCTestCase {

    func testThis() {
        
        let sequence: [CalcLaterSymbol] = [.Two, .PlusSign, .One, .Two, .DecimalSign, .Nine]
        let tailSequence = CalcLaterSymbol.tailDigitSequence(sequence)
        
        XCTAssert(true)
    }
    
//    func testSingleDigitSequence() {
//        // 1
//        let sequence: [CalcLaterSymbol] = [.One]
//        let result = CalcLaterEngine.computeExpressionValue(sequence)
//        let expectation = "1"
//        
//        XCTAssertEqual(result, expectation, "the result should be the digit value")
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
