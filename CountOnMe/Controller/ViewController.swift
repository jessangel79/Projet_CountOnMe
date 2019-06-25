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
    
    // MARK: - Methods
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorOperator),
                                               name: Notification.Name(rawValue: "AlertErrorOperator"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorExpressionIncorrect),
                                               name: Notification.Name(rawValue: "AlertErrorExpressionIncorrect"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorNewCalcul),
                                               name: Notification.Name(rawValue: "AlertErrorNewCalcul"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertDivideByZeroImpossible),
                                               name: Notification.Name(rawValue: "AlertDivideByZeroImpossible"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorArrayEmpty),
                                               name: Notification.Name(rawValue: "AlertErrorArrayEmpty"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalc(notification:)),
                                               name: Notification.Name(rawValue: "DisplayCalc"),
                                               object: nil)
    }
    
    @objc func alertErrorOperator() {
        alertVC(title: "Zéro", message: "Un operateur est déja mis !")
    }
    
    @objc func alertErrorExpressionIncorrect() {
        alertVC(title: "Zéro", message: "Entrez une expression correcte !")
    }
    
    @objc func alertErrorNewCalcul() {
        alertVC(title: "Zéro", message: "Démarrez un nouveau calcul !")
    }
    
    @objc func alertDivideByZeroImpossible() {
        alertVC(title: "Zéro", message: "La division par zéro est impossible !")
    }
    
    @objc func alertErrorArrayEmpty() {
        alertVC(title: "Zéro", message: "Veuillez saisir un chiffre !")
    }
    
    @objc func displayCalc(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["calcul"] as? String
    }
    
    // MARK: - Actions
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calc.addNewNumber(stringNumber: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calc.operation(operand: .addition)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calc.operation(operand: .subtraction)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calc.operation(operand: .multiplication)
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calc.operation(operand: .division)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calc.calculate()
    }

    private func alertVC(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
