//
//  SignInViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/19/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func doneButtonWasPressed(_ sender: UIBarButtonItem) {
        self.signInUser()
    }
    
    private func signInUser() {
        let user = User()
        user.email = self.emailTextField.text!
        user.password = self.passwordTextField.text!
        user.signIn { data, response, error in
            guard let response = (response as? HTTPURLResponse) else { return }
            if response.statusCode == 201 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "DayCares", sender: nil)
                }
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == passwordTextField else { return false }
        self.signInUser()
        return false
    }
}
