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
    
    private func createDayCare() {
        let dayCare = DayCare()
        dayCare.name = self.nameTextField.text!
        dayCare.post { data, response, error in
            if error == nil {
                self.dismiss(animated: true)
            }
        }
    }
}
