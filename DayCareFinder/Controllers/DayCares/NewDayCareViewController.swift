//
//  NewDayCareViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/18/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class NewDayCareViewController: UIViewController {
    
    @IBOutlet public weak var nameTextField: UITextField!
    
    @IBOutlet public weak var addressTextField: UITextField!
    
    @IBOutlet public weak var cityTextField: UITextField!
    
    @IBOutlet public weak var stateTextField: UITextField!
    
    @IBOutlet public weak var zipCodeTextField: UITextField!
    
    @IBOutlet public weak var phoneNumberTextField: UITextField!
    
    @IBAction public func doneButtonWasTouched(_ sender: UIBarButtonItem) {
        self.createDayCare()
    }
    
    @IBAction func submitButtonWasTouched(_ sender: UIButton) {
        self.createDayCare()
    }
    
    
    private func createDayCare() {
        let dayCare = DayCare()
        dayCare.name = self.nameTextField.text!
        dayCare.address = self.addressTextField.text!
        dayCare.city = self.cityTextField.text!
        dayCare.state = self.stateTextField.text!
        dayCare.zipCode = self.zipCodeTextField.text!
        dayCare.phoneNumber = self.phoneNumberTextField.text!
        UIApplication.shared.beginWaitingForNetworkResponse()
        dayCare.post { data, response, error in
            UIApplication.shared.endWaitingForNetworkResponse()
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "Index", sender: nil)
                }
            }
        }
    }
}

extension NewDayCareViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == self.phoneNumberTextField else { return false }
        self.createDayCare()
        return false
    }
}
