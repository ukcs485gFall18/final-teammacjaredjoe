//
//  UserMenuViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/24/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class UserMenuViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        if !self.menuView.frame.contains(touch.location(in: super.view)) {
            super.performSegue(withIdentifier: "DayCares", sender: nil)
        }
    }
}
