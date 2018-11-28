//
//  UserMenuViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/24/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class UserMenuViewController: UIViewController {
    
    public var dayCare: DayCare?
    
    @IBOutlet public weak var menuView: UIView!
    
    @IBOutlet public weak var currentUserEmailLabel: UILabel!
    
    @IBOutlet public weak var dayCareButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.currentUserEmailLabel.text! = User.currentUser!.email!
        }
        User.currentUser!.getDayCare { data, response, error in
            DispatchQueue.main.async {
                if let dayCare = User.currentUser!.dayCare {
                    self.dayCare = dayCare
                    self.dayCareButton.titleLabel?.text = "My day care"
                }
                else {
                    self.dayCareButton.titleLabel!.text = "Manage a day care"
                }
            }
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
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show" {
            self.prepareForShow(segue: segue, sender: sender)
        }
    }
    
    private func prepareForShow(segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! DayCareViewController
        viewController.dayCare = self.dayCare
    }
    
    @IBAction public func myKidsButtonTouched(_ sender: UIButton) {
        DispatchQueue.main.async {
            super.performSegue(withIdentifier: "Kids", sender: nil)
        }
    }
    
    @IBAction public func dayCareButtonTouched(_ sender: UIButton) {
        if let _ = self.dayCare {
            DispatchQueue.main.async {
                super.performSegue(withIdentifier: "MyDayCare", sender: nil)
            }
        }
        else {
            self.presentCreateDayCarePrompt()
        }
    }
    
    private func presentCreateDayCarePrompt() {
        let title = "Manage a Day Care"
        let message = "A user may become the manager of a single day care. Create a day care?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { action in
            DispatchQueue.main.async {
                super.performSegue(withIdentifier: "New", sender: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
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
