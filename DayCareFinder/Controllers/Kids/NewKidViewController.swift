//
//  NewKidViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/26/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class NewKidViewController: UIViewController {
    
    private let detailsTextViewPlaceholderText = "Details (e.g., disabilities, allergies, etc.)"
    
    @IBOutlet public weak var firstNameTextField: UITextField!
    
    @IBOutlet public weak var lastNameTextField: UITextField!
    
    @IBOutlet public weak var ageTextField: UITextField!
    
    @IBOutlet public weak var detailsTextView: UITextView!
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.textViewDidEndEditing(self.detailsTextView)
    }
    
    @IBAction func doneButtonWasTouched(_ sender: UIBarButtonItem) {
        let kid = Kid()
        kid.firstName = self.firstNameTextField.text!
        kid.lastName = self.lastNameTextField.text!
        kid.age = Int(self.ageTextField.text!)!
        kid.details = self.detailsTextView.text!
        UIApplication.shared.beginWaitingForNetworkResponse()
        kid.post { data, response, error in
            UIApplication.shared.endWaitingForNetworkResponse()
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "Index", sender: nil)
                }
            }
        }
    }
    
    @IBAction func saveChildButtonWasTouched(_ sender: UIButton) {
        let kid = Kid()
        kid.firstName = self.firstNameTextField.text!
        kid.lastName = self.lastNameTextField.text!
        kid.age = Int(self.ageTextField.text!)!
        kid.details = self.detailsTextView.text!
        UIApplication.shared.beginWaitingForNetworkResponse()
        kid.post { data, response, error in
            UIApplication.shared.endWaitingForNetworkResponse()
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "Index", sender: nil)
                }
            }
        }
    }
}

extension NewKidViewController: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if self.detailsTextView.text == detailsTextViewPlaceholderText {
            self.detailsTextView.text = ""
            self.detailsTextView.textColor = UIColor.darkText
        }
        self.detailsTextView.becomeFirstResponder()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if self.detailsTextView.text.isEmpty {
            self.detailsTextView.text = detailsTextViewPlaceholderText
            self.detailsTextView.textColor = UIColor.lightGray
        }
        self.detailsTextView.resignFirstResponder()
    }
}
