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
    
    // MARK: - Tests
    
    // Test - Addition
    func testGivenOneAddTwo_WhenCalculate_ThenResultIsThree() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.operation(operand: .addition)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertFalse(calculator.arrayIsEmpty)
        XCTAssertEqual(calculator.calcul, "1 + 2 = 3")
        XCTAssertEqual(calculator.calcul.last, "3")
    }
    
    // Test - Subtraction
    func testGivenThreeSubtractTwo_WhenCalculate_ThenResultIsOne() {
        calculator.addNewNumber(stringNumber: "3")
        calculator.operation(operand: .subtraction)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertFalse(calculator.arrayIsEmpty)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertEqual(calculator.calcul, "3 - 2 = 1")
        XCTAssertEqual(calculator.calcul.last, "1")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "1")
    }
    
    // Test - Multiplication
    func testGivenTwoMultiplyThree_WhenCalculate_ThenResultIsSix() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.operation(operand: .multiplication)
        calculator.addNewNumber(stringNumber: "3")
        calculator.calculate()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertEqual(calculator.calcul, "2 x 3 = 6")
        XCTAssertEqual(calculator.calcul.last, "6")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "6")
    }
    
    // Test - Division
    func testGivenSixDivideTwo_WhenCalculate_ThenResultIsThree() {
        calculator.addNewNumber(stringNumber: "6")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "2")
        calculator.calculate()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertEqual(calculator.calcul, "6 / 2 = 3")
        XCTAssertEqual(calculator.calcul.last, "3")
        XCTAssertEqual(String(calculator.calcul.last!), calculator.operationsToReduce.first ?? "3")
    }

    // Test priority operator
    func testGivenCalculWithAllOperators_WhenCalculate_ThenResultIsOk() {
        calculator.addNewNumber(stringNumber: "255")
        calculator.operation(operand: .addition)
        calculator.addNewNumber(stringNumber: "10")
        calculator.operation(operand: .multiplication)
        calculator.addNewNumber(stringNumber: "40")
        calculator.operation(operand: .subtraction)
        calculator.addNewNumber(stringNumber: "235")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "5")
        calculator.operation(operand: .multiplication)
        calculator.addNewNumber(stringNumber: "6")
        calculator.operation(operand: .addition)
        calculator.addNewNumber(stringNumber: "3")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "111")
        calculator.calculate()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertEqual(calculator.calcul, "255 + 10 x 40 - 235 / 5 x 6 + 3 / 111 = 373.027")
    }
    
    // Test - Division by zero
    func testGivenDivisionByZeroImpossible_WhenDivisionByZero_ThenIsFalse() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.operation(operand: .division)
        calculator.addNewNumber(stringNumber: "0")
        calculator.calculate()
        
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertFalse(calculator.expressionDivisionByZero)
    }
    
    // Test - Error types
    func testGivenCalculWithOneNumber_WhenExpressionHaveNotEnoughElement_ThenMessageErrorNewCalcul() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.calculate()
        
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }
    
    func testGivenCalculWithoutNumber_WhenArrayIsEmpty_ThenMessageErrorNewCalcul() {
        calculator.calculate()
        
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertTrue(calculator.arrayIsEmpty)
        XCTAssertEqual(calculator.calcul, String())
    }
    
    func testGivenCalculWithOperandInFirst_WhenArrayIsEmpty_ThenMessagePutOneNumber() {
        calculator.operation(operand: .multiplication)
        
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertTrue(calculator.arrayIsEmpty)
        XCTAssertEqual(calculator.calcul, String())
        XCTAssertNotNil(calculator.calcul)
    }
    
    func testGivenCalculWithTwoOperandsSuccessive_WhenCanNotAddOperator_ThenMessageErrorOperator() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.operation(operand: .addition)
        calculator.operation(operand: .multiplication)

        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertFalse(calculator.arrayIsEmpty)
        XCTAssertNotNil(calculator.calcul)
        XCTAssertFalse(calculator.expressionIsCorrect)
        XCTAssertFalse(calculator.canAddOperator)
        XCTAssertEqual(calculator.calcul, "1 + ")
    }
    
    func testGivenCalculWithOperandAndEgalSucessive_WhenExpressionIsIncorrect_ThenMessageErrorExpression() {
        calculator.addNewNumber(stringNumber: "3")
        calculator.operation(operand: .addition)
        calculator.addNewNumber(stringNumber: "5")
        calculator.operation(operand: .multiplication)
        calculator.calculate()
        
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssertFalse(calculator.arrayIsEmpty)
        XCTAssertNotNil(calculator.calcul)
        XCTAssertFalse(calculator.expressionIsCorrect)
        XCTAssertFalse(calculator.canAddOperator)
        XCTAssertEqual(calculator.calcul, "3 + 5 x ")
    }
    
}
