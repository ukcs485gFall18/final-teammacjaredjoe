//
//  SignUpViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/19/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class SignUpViewController: UIViewController {
    
    @IBOutlet public weak var emailTextField: UITextField!
    
    @IBOutlet public weak var passwordTextField: UITextField!
    
    @IBOutlet public weak var passwordConfirmationTextField: UITextField!
    
    @IBAction public func doneButtonWasPressed(_ sender: UIBarButtonItem) {
        self.signUpUser()
    }
    
    @IBAction func submitButtonWasPressed(_ sender: UIButton) {
        self.signUpUser()
    }
    
    private func signUpUser() {
        let user = User()
        user.email = self.emailTextField.text!
        user.password = self.passwordTextField.text!
        user.passwordConfirmation = self.passwordConfirmationTextField.text!
        UIApplication.shared.beginWaitingForNetworkResponse()
        user.signUp { data, response, error in
            UIApplication.shared.endWaitingForNetworkResponse()
            guard let response = (response as? HTTPURLResponse) else { return }
            if response.statusCode == 201 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "DayCares", sender: nil)
                }
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == self.passwordConfirmationTextField else { return false }
        self.signUpUser()
        return false
    }
}
