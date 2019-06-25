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
    func testGivenOperatorIsNotNegativeOrNotPositive_WhenExpressionIsCorrect_ThenIsTrue() {
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testGivenNumberElementIsGreaterThanThree_WhenHaveEnoughElement_ThenIsTrue() {
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
    }
    
    func testGivenOperatorIsNotLast_WhenAddOperator_ThenIsTrue() {
        XCTAssertTrue(calculator.canAddOperator)
    }
    
    func testGivenFirstIndexCalculEgalIsNotNil_WhenHaveResult_ThenIsTrue() {
        XCTAssertTrue(calculator.expressionHaveResult)
    }

    func testGivenDisplayCalcIsEqualCalcul_WhenDisplayCalc_ThenIsEqual() {
        XCTAssertEqual(calculator.displayCalc(), calculator.calcul)
    }
    
    func testGivenArrayOperationToReduceIsEmpty_WhenAccessingIt_ThenItExists() {
        XCTAssert(calculator.operationsToReduce == [])
    }
    
    func testGivenArrayElementsIsNotEmpty_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(calculator.elements)
    }
    
    func testGivenVarCalculIsNotEmpty_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(calculator.calcul)
    }
    
    func testGivenArrayEmpty_WhenArrayIsEmpty_ThenIsTrue() {
        calculator.calcul = String()
        XCTAssertTrue(calculator.arrayIsEmpty)
    }
    
    func testGivenDivisionByZeroImpossible_WhenExpressionDivisionByZero_ThenIsFalse() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "0")
        calculator.calculate()
        XCTAssertFalse(calculator.expressionDivisionByZero)
    }
    
    // Test - Add ###
    func testGivenOneAddTwo_WhenCalculate_ThenResultIsThree() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.operation(operand: .addition)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        XCTAssertEqual(calculator.calcul, "1 + 2 = 3")
        XCTAssertEqual(calculator.calcul.last, "3")
        XCTAssertNotNil(calculator.calcul)
        XCTAssertFalse(calculator.arrayIsEmpty)
    }
    
    // Test - Subtract ###
    func testGivenThreeSubtractTwo_WhenCalculate_ThenResultIsOne() {
        calculator.addNewNumber(stringNumber: "3")
        calculator.operation(operand: .subtraction)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        XCTAssertEqual(calculator.calcul, "3 - 2 = 1")
        XCTAssertEqual(calculator.calcul.last, "1")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "1")
        XCTAssertNotNil(calculator.calcul)
        XCTAssertFalse(calculator.arrayIsEmpty)
    }
    
    // Test - Multiply ###
    func testGivenTwoMultiplyThree_WhenCalculate_ThenResultIsSix() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.operation(operand: .multiplication)
        calculator.addNewNumber(stringNumber: "3")
        calculator.calculate()
        XCTAssertEqual(calculator.calcul, "2 x 3 = 6")
        XCTAssertEqual(calculator.calcul.last, "6")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "6")
    }
    
    // Test - Divide ###
    func testGivenSixDivideTwo_WhenCalculate_ThenResultIsThree() {
        calculator.addNewNumber(stringNumber: "6")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        XCTAssertEqual(calculator.calcul, "6 / 2 = 3")
        XCTAssertEqual(calculator.calcul.last, "3")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "3")
    }
    
    func testGivenNotificationIsSendingErrorNewCalcul_WhenErrorType_ThenErrorNewCalcul() {
        let errorNewCalcul = Calculator.ErrorType(rawValue: "AlertErrorNewCalcul")
        calculator.calcul = String()
        XCTAssertNotNil(calculator.calcul)
        XCTAssertNoThrow(calculator.calcul)
        XCTAssertEqual(errorNewCalcul?.rawValue, "AlertErrorNewCalcul")
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }
    
        func testGivenNotificationIsSendingErrorOperator_WhenErrorType_ThenErrorOperator() {
            let errorOperator = Calculator.ErrorType(rawValue: "AlertErrorOperator")
            calculator.addNewNumber(stringNumber: "1")
            calculator.operation(operand: .addition)
            calculator.addNewNumber(stringNumber: "x")
            calculator.calculate()
            XCTAssertEqual(errorOperator?.rawValue, "AlertErrorOperator")
            XCTAssertNotNil(calculator.calcul)
            XCTAssertFalse(calculator.arrayIsEmpty)
        }
    
//    func testGivenNotificationIsSendingErrorNotHaveEnoughElement_WhenErrorType_ThenErrorNewCalcul() {
//        let errorNotHaveEnoughElement = Calculator.ErrorType(rawValue: "AlertErrorNewCalcul")
//        calculator.addNewNumber(stringNumber: "1")
//        calculator.calculate()
//        XCTAssertEqual(errorNotHaveEnoughElement?.rawValue, "AlertErrorNewCalcul")
//        XCTAssertNotNil(calculator.calcul)
//        XCTAssertFalse(calculator.expressionHaveEnoughElement)
//    }
    
    func testGivenNotificationIsSendingErrorArrayEmpty_WhenErrorType_ThenErrorArrayEmpty() {
        let errorNotHaveEnoughElement = Calculator.ErrorType(rawValue: "AlertErrorArrayEmpty")
        calculator.operation(operand: .multiplication)
        calculator.calculate()
        XCTAssertEqual(errorNotHaveEnoughElement?.rawValue, "AlertErrorArrayEmpty")
        XCTAssertNotNil(calculator.calcul)
        XCTAssertTrue(calculator.arrayIsEmpty)
    }
}
