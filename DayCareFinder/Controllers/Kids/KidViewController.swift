//
//  KidViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/26/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class KidViewController: UIViewController {
    
    public var kid: Kid? {
        didSet {
            self.reloadData()
        }
    }
    
    @IBOutlet public weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameAndAgeTextView: UITextView!
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.refreshControl = UIRefreshControl()
        self.scrollView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        self.reloadData()
    }
    
    @IBAction public func trashButtonWasTouched(_ sender: UIBarButtonItem) {
        let title = "Are you sure?"
        let message = "You cannot undo this action."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.destroyKid()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        DispatchQueue.main.async {
            super.present(alertController, animated: true)
        }
    }
    
    @objc private func updateData() {
        self.kid?.get { data, response, error in
            DispatchQueue.main.async {
                self.reloadData()
                self.scrollView.refreshControl!.endRefreshing()
            }
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            guard let kid = self.kid else { return }
            self.nameAndAgeTextView?.text = kid.name! + ", " + String(kid.age!)
            if let details = kid.details, !details.isEmpty {
                self.detailsTextView?.text = details
            }
            else {
                self.detailsTextView?.text = "No details provided."
            }
        }
    }
    
    private func destroyKid() {
        self.kid!.delete { data, response, error in
            DispatchQueue.main.async {
                super.dismiss(animated: true)
            }
        }
    }
}

