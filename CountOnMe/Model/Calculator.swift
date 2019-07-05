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
    
    // separates the elements of the calculation
    private var elements: [String] {
        return calcul.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    // checks if expression is correct and can be calculated
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    // checks if expression has enough elements to be calculated
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    // checks if an operator can be added
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    // checks if the expression has a result
    var expressionHaveResult: Bool {
        return calcul.firstIndex(of: "=") != nil
    }
    
    // checks if a number has been entered
    var arrayIsEmpty: Bool {
        return elements.count == 0
    }
    
    // check division by zero
    var expressionDivisionByZero: Bool {
        return (elements.firstIndex(of: "/") != nil) && elements.contains("0")
    }

    // check priority for multiplication and division
    private var priorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }
    
    // enumerates of addition, subtraction, multiplication or division operand
    enum Operand: String {
        case addition = " + "
        case subtraction = " - "
        case multiplication = " x "
        case division = " / "
    }

    // MARK: - Methods
    
    // notification to display error alerts
    private func notificationSending(message: String) {
        let name = Notification.Name(rawValue: "error")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["errorMessage": message])
    }
    
    // adds a number to property "calcul" and erases the old calcul if already done
    func addNewNumber(stringNumber: String) {
        refreshCalc()
        calcul.append(stringNumber)
    }
    
    // adds addition, subtraction, multiplication or division operators
    func operation(operand: Operand) {
        refreshCalc()
        if arrayIsEmpty {
            notificationSending(message: "Veuillez saisir un chiffre !")
        } else if canAddOperator {
            calcul.append(operand.rawValue)
        } else {
            notificationSending(message: "Un operateur est déja mis !")
        }
    }
    
    // multiplication and division : Get priority for operator * and /
    private func priority(expression: [String]) -> [String] {
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
        refreshCalc()
        
        // checks if expression is correct else return an alert message
        guard expressionIsCorrect else {
            notificationSending(message: "Entrez une expression correcte !")
            return
        }
        // checks if expression has enough elements to be calculated else return an alert message
        guard expressionHaveEnoughElement else {
            notificationSending(message: "Démarrez un nouveau calcul !")
            return
        }
        // checks if division by zero, return an alert message and reset propriety "calcul"
        guard !expressionDivisionByZero else {
            notificationSending(message: "La division par zéro est impossible !")
            calcul = String()
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        // checks if mutiplication and division are presents in the calculation and gets priority for operators * and /
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
            default: notificationSending(message: "Entrez une expression correcte !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(removeDotZero(result: result))", at: 0)
        }
        guard let result = operationsToReduce.first else { return }
        calcul.append(" = \(result)")
    }
    
    // reset property "calcul" after a calcul already done
    private func refreshCalc() {
        if expressionHaveResult {
            calcul = String()
        }
    }
    
    // remove dot and zero to display an integer
    private func removeDotZero(result: Double) -> String {
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: result)), number: .decimal)
        return doubleAsString
    }
}
