//
//  UserMenuViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/24/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class UserMenuViewController: UIViewController {
    
    @IBOutlet public weak var menuView: UIView!
    
    @IBOutlet public weak var currentUserEmailLabel: UILabel!
    
    @IBOutlet weak var dayCareButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserEmailLabel.text! = User.currentUser!.email!
        if let _ = User.currentUser!.dayCare {
            self.dayCareButton.titleLabel?.text = "My day care"
        }
        else {
            self.dayCareButton.titleLabel!.text = "Manage a day care"
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        if !self.menuView.frame.contains(touch.location(in: super.view)) {
            DispatchQueue.main.async {
                super.performSegue(withIdentifier: "DayCares", sender: nil)
            }
        }
    }
    
    @IBAction public func myKidsButtonTouched(_ sender: UIButton) {
        DispatchQueue.main.async {
            super.performSegue(withIdentifier: "Kids", sender: nil)
        }
    }
    
    @IBAction public func dayCareButtonTouched(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Manage a Day Care",
            message: "A user may become the manager of a single day care. Create a day care?",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Create", style: .default) { action in
            DispatchQueue.main.async {
                super.performSegue(withIdentifier: "New", sender: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        DispatchQueue.main.async {
            super.present(alertController, animated: true)
        }
    }
    
    @IBAction public func signOutButtonTouched(_ sender: UIButton) {
        User.currentUser = nil
        DispatchQueue.main.async {
            super.performSegue(withIdentifier: "Users", sender: nil)
        }
    }
}
