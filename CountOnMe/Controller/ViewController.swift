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
    private let calc = Calculator()
    
    // MARK: - Methods
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalc(notification:)),
                                               name: Notification.Name(rawValue: "DisplayCalc"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertError(notification:)),
                                               name: Notification.Name(rawValue: "error"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func displayCalc(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["calcul"] as? String
    }
    
    @objc private func alertError(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let errorMessage = userInfo["errorMessage"] as? String else { return }
        alertVC(title: "Zéro", message: errorMessage)
    }
    
    // MARK: - Actions
    // enter a number
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calc.addNewNumber(stringNumber: numberText)
    }
    
    // call of the operation methods to calculate
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
    
    // sends an alert message to user
    private func alertVC(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
