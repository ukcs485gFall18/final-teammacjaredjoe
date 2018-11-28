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
        let alertController = UIAlertController(title: "Are you sure?", message: "You can not undo this action.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.destroyKid()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        super.present(alertController, animated: true)
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
            self.nameAndAgeTextView.text = kid.name! + ", " + String(kid.age!)
            if let details = kid.details {
                self.detailsTextView.text = details
            }
            else {
                self.detailsTextView.text = "No details provided."
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

