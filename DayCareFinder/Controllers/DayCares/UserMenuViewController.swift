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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserEmailLabel.text! = User.currentUser!.email!
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        if !self.menuView.frame.contains(touch.location(in: super.view)) {
            super.performSegue(withIdentifier: "DayCares", sender: nil)
        }
    }
    
    @IBAction public func myKidsButtonTouched(_ sender: UIButton) {
    }
    
    @IBAction public func dayCareButtonTouched(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Manage a Day Care",
            message: "An account may become the manager of a single day care. Create a day care?",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            super.performSegue(withIdentifier: "New", sender: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        super.present(alertController, animated: true)
    }
    
    @IBAction public func signOutButtonTouched(_ sender: UIButton) {
        UIApplication.shared.beginWaitingForNetworkResponse()
        User.currentUser!.signOut { data, response, error in
            UIApplication.shared.endWaitingForNetworkResponse()
            guard let response = (response as? HTTPURLResponse) else { return }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    super.performSegue(withIdentifier: "Users", sender: nil)
                }
            }
        }
    }
}
