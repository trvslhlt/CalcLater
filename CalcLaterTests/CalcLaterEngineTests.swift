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

//    func testThis() {
//        
//        let sequence: [CalcLaterSymbol] = [.Two, .PlusSign, .One, .Two, .DecimalSign, .Nine]
//        let tailSequence = CalcLaterSymbol.tailDigitSequence(sequence)
//        
//        XCTAssert(true)
//    }
    
    func testSequenceWithArithmeticOperatorEndingWithDigitSequence() {
        // 7 6 . 9 + 3 0
        let sequence = [CalcLaterSymbol.Seven, .Six, .DecimalSign, .Nine, .PlusSign, .Three, .Zero]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "30"
        XCTAssertEqual(result, expectation, "the result should contain two digits followed by a decimal and another digit")
    }

    func testSequenceEndingInArithmeticOperator() {
        // 7 6 . 9 x
        let sequence = [CalcLaterSymbol.Seven, .Six, .DecimalSign, .Nine, .PlusSign]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "76.9"
        XCTAssertEqual(result, expectation, "the result should contain two digits followed by a decimal and another digit")
    }
    
    func testMultiDigitSequenceContainingDecimal() {
        // 7 6 . 9
        let sequence = [CalcLaterSymbol.Seven, .Six, .DecimalSign, .Nine]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "76.9"
        XCTAssertEqual(result, expectation, "the result should contain two digits followed by a decimal and another digit")
    }
    
    func testMultiDigitSequenceEndingInDecimal() {
        // 7 6 .
        let sequence = [CalcLaterSymbol.Seven, CalcLaterSymbol.Six, CalcLaterSymbol.DecimalSign]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "76."
        XCTAssertEqual(result, expectation, "the result should contain two digits followed by a decimal")
    }

    
    func testMultiDigitSequence() {
        // 7 6
        let sequence = [CalcLaterSymbol.Seven, CalcLaterSymbol.Six]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "76"
        XCTAssertEqual(result, expectation, "the result should contain two digits")
    }
    
    func testSingleDigitSequence() {
        // 1
        let sequence: [CalcLaterSymbol] = [.One]
        let result = CalcLaterEngine.computeOutputvalueForSequence(sequence)
        let expectation = "1"
        
        XCTAssertEqual(result, expectation, "the result should be the digit value")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
