//
//  CalcLaterTests.swift
//  CalcLaterTests
//
//  Created by trvslhlt on 10/26/15.
//  Copyright © 2015 travis holt. All rights reserved.
//

import XCTest
@testable import CalcLater

class CalcLaterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        CalcLater.sharedInstance.input(CalcLaterConstants.clearAllSign)
    }
    
    func testClearInput() {
        
        CalcLater.sharedInstance.input("9")
        CalcLater.sharedInstance.input(CalcLaterConstants.clearSign)
        let output = CalcLater.sharedInstance.output
        
        XCTAssertEqual(output, "0", "output should be zero after inputting clear")
    }
    
    func testClearAllInput() {
        CalcLater.sharedInstance.input("1")
        CalcLater.sharedInstance.input(CalcLaterConstants.multiplySign)
        CalcLater.sharedInstance.input("5")
        CalcLater.sharedInstance.input(CalcLaterConstants.equalsSign)
        CalcLater.sharedInstance.input(CalcLaterConstants.clearAllSign)
        let output = CalcLater.sharedInstance.output
        
        XCTAssertEqual(output, "", "output should be nothing")
    }
    
    func testInitialInputEquals() {
        CalcLater.sharedInstance.input("=")
        let output = CalcLater.sharedInstance.output
        
        XCTAssertEqual(output, "", "there should be no output characters")
    }
    
    func testInputDigit() {
        let number: Double = 1
        let digit = "\(number)"
        CalcLater.sharedInstance.input(digit)
        let output = CalcLater.sharedInstance.output
        XCTAssertEqual(number, Double(output)!, "output should equal input")
    }
}
