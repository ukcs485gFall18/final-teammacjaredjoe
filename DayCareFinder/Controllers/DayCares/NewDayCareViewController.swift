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
        let dayCare = DayCare(id: nil, name: self.nameTextField.text!)
        DayCare.save(dayCare) { error in
            guard let _ = error else {
                self.dismiss(animated: true)
                return
            }
        }
    }
}
