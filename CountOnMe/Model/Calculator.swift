//
//  Calculator.swift
//  CountOnMe
//
//  Created by Angelique Babin on 05/06/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    // MARK: - Properties
    var operationsToReduce = [String]()
    
    var calcul: String = "1 + 1 = 2" {
        didSet {
            print(calcul)
            let name = Notification.Name(rawValue: "DisplayCalc")
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["calcul": calcul])
        }
    }
    
    var elements: [String] {
        return calcul.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return calcul.firstIndex(of: "=") != nil
    }
    
    // Check if a number has been entered
    var arrayIsEmpty: Bool {
        return elements.count == 0
    }
    
    // Check division by zero
    var expressionDivisionByZero: Bool {
        return (elements.firstIndex(of: "/") != nil) && elements.contains("0")
    }

    // Check priority for multiplication and division
    var priorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }
    
    // Enum Error type
    enum ErrorType: String {
        case newCalcul = "AlertErrorNewCalcul"
        case incorrectExpression = "AlertErrorExpressionIncorrect"
        case errorOperator = "AlertErrorOperator"
        case divideByZero = "AlertDivideByZeroImpossible"
        case errorArrayEmpty = "AlertErrorArrayEmpty"
    }
    
    // Enum Operand to function calculation(operand: Operand)
    enum Operand: String {
        case addition = " + "
        case subtraction = " - "
        case multiplication = " x "
        case division = " / "
    }

    // MARK: - Methods
    func notificationSending(typeError: ErrorType) {
        let name = Notification.Name(rawValue: typeError.rawValue)
        NotificationCenter.default.post(Notification(name: name))
    }
    
    func addNewNumber(stringNumber: String) {
        refreshCalc()
        calcul.append(stringNumber)
    }
    
    func operation(operand: Operand) {
        refreshCalc()
        if arrayIsEmpty {
            notificationSending(typeError: ErrorType.errorArrayEmpty)
        } else if canAddOperator {
            calcul.append(operand.rawValue)
        } else {
            notificationSending(typeError: ErrorType.errorOperator)
        }
    }
    
    // Multiplication and division
    func priority(expression: [String]) -> [String] {
        var tempExpression: [String] = expression
        while tempExpression.contains("x") || tempExpression.contains("/") {
            if let indexTempExpression = tempExpression.firstIndex(where: {$0 == "x" || $0 == "/"}) {
                let operand = tempExpression[indexTempExpression]
                guard let leftNumber = Double(tempExpression[indexTempExpression - 1]) else { return [] }
                guard let rightNumber = Double(tempExpression[indexTempExpression + 1]) else { return [] }
                let result: Double
                if operand == "x" {
                    result = leftNumber * rightNumber
                } else {
                    result = leftNumber / rightNumber
                }
                tempExpression[indexTempExpression - 1] = String(removeDotZero(result: result))
                tempExpression.remove(at: indexTempExpression + 1)
                tempExpression.remove(at: indexTempExpression)
            }
        }
        return tempExpression
    }
    
    func calculate() {
        
        guard expressionIsCorrect else {
            notificationSending(typeError: ErrorType.incorrectExpression)
            return
        }
        
        guard expressionHaveEnoughElement else {
            notificationSending(typeError: ErrorType.newCalcul)
            return
        }
        
        // Division by zero
        guard !expressionDivisionByZero else {
            notificationSending(typeError: ErrorType.divideByZero)
            calcul = String()
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Mutiplication & division priority
        if priorityOperator {
            operationsToReduce = priority(expression: elements)
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            guard let left = Double(operationsToReduce[0]) else { return }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else { return }

            var result: Double = 0.0
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: notificationSending(typeError: ErrorType.incorrectExpression)
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(removeDotZero(result: result))", at: 0)
        }
        guard let result = operationsToReduce.first else { return }
        calcul.append(" = \(result)")
    }
    
    // reset property "calcul"
    private func refreshCalc() {
        if expressionHaveResult {
            calcul = String()
        }
    }
    
    // display the calcul input by the user
    func displayCalc() -> String {
        let text = calcul
        return text
    }
    
    // remove dot and zero to display an integer
    func removeDotZero(result: Double) -> String {
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: result)), number: .decimal)
        return doubleAsString
    }

} // END class Calculator
