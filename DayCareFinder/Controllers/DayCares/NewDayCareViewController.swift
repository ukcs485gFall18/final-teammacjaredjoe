//
//  NewDayCareViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/18/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class NewDayCareViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: TextField!
    
    @IBAction func touchDoneButton(_ sender: UIBarButtonItem) {
        self.createDayCare()
    }
    
    @IBAction public func touchCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func createDayCare() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try! encoder.encode(["day_care": DayCare(id: 0, name: self.nameTextField.text!)])
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/day_cares.json")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            self.dismiss(animated: true, completion: nil)
        } .resume()
    }
}

extension NewDayCareViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.createDayCare()
        return true
    }
}
