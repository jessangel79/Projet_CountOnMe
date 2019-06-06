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
        }
    }
    
    var elements: [String] {
        return calcul.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return calcul.firstIndex(of: "=") != nil
    }
    
    enum AlertError: Error {
        case newCalc, operatorAlreadySet, incorrectExpression

        var title: String {
            return "Zéro"
        }

        var message: String {
            switch self {
            case .newCalc:
                return "Démarrez un nouveau calcul !"
            case .operatorAlreadySet:
                return "Un operateur est déja mis !"
            case .incorrectExpression:
                return "Entrez une expression correcte !"
            }
        }
    }
    
    // MARK: - Methods
    func notificationSending() {
        let name = Notification.Name(rawValue: "ResultCalculate")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    func addNewNumber(stringNumber: String) {
        if expressionHaveResult {
            calcul = ""
        }
        calcul.append(stringNumber)
    }
    
    func addition() {
        calcul.append(" + ")
    }
    
    func substraction() {
        calcul.append(" - ")
    }
    
    func multiplication() {
        calcul.append(" x ")
    }
    
    func division() {
        calcul.append(" / ")
    }
    
    func calculate() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        guard let result = operationsToReduce.first else { return }
        calcul.append(" = \(result)")
        notificationSending()
    }
    
    func displayCalc() -> String {
        let text = calcul
        return text
    }
    
//    func displayCalc() -> String {
//        var text = ""
//        for element in elements {
//            text = element
//        }
//        return text
//    }
    
}
