//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Angelique Babin on 30/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    
    // MARK: - Properties
    var calculator: Calculator!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Helpers
    
    // MARK: - Tests
    func testGivenInstanceOfCalculator_WhenAccessingIt_ThenItExists() {
        
        XCTAssertNotNil(calculator)
    }
    
    func testGivenOperatorIsNotNegativeOrNotPositive_WhenExpressionIsCorrect_ThenIsTrue() {
        
        XCTAssertTrue(calculator.expressionIsCorrect)

    }
    
    func testGivenOperatorIsNotLast_WhenAddOperator_ThenIsTrue() {
        XCTAssertTrue(calculator.canAddOperator)
    }
    
    // MARK: - Tests Example
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
