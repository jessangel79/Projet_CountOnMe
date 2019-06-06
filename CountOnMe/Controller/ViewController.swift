//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Properties
    var calc = Calculator()
    
//    var elements: [String] {
//        return textView.text.split(separator: " ").map { "\($0)" }
//    }
    
//    // Error check computed variables
//    var expressionIsCorrect: Bool {
//        return elements.last != "+" && elements.last != "-"
//    }
    
//    var expressionHaveEnoughElement: Bool {
//        return elements.count >= 3
//    }
//
//    var canAddOperator: Bool {
//        return elements.last != "+" && elements.last != "-"
//    }
    
//    var expressionHaveResult: Bool {
//        return textView.text.firstIndex(of: "=") != nil
//    }
    
    // MARK: - Methods
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "ResultCalculate")
        NotificationCenter.default.addObserver(self, selector: #selector(resultCalculate), name: name, object: nil)
    }
    
    @objc func resultCalculate() {
        textView.text = calc.calcul
    }
    
    // MARK: - Actions
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calc.addNewNumber(stringNumber: numberText)
        textView.text = calc.displayCalc()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calc.canAddOperator {
            calc.addition()
            textView.text = calc.displayCalc()
        } else {
            alertVC(alertError: .operatorAlreadySet)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calc.canAddOperator {
            calc.substraction()
            textView.text = calc.displayCalc()
        } else {
            alertVC(alertError: .operatorAlreadySet)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calc.expressionIsCorrect else {
            return alertVC(alertError: .incorrectExpression)
        }
        
        guard calc.expressionHaveEnoughElement else {
            return alertVC(alertError: .newCalc)
        }
        
        calc.calculate()
    }
    
    private func alertVC(alertError: Calculator.AlertError) {
        let alertVC = UIAlertController(title: alertError.title, message: alertError.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

//    private func alertVC(title: String, message: String) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }

}
