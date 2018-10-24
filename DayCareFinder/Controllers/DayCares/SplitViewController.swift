//
//  SplitViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/16/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class SplitViewController: UISplitViewController {

    public override func viewDidLoad() {
        self.delegate = self
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
