//
//  DayCareViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/16/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import MapKit
import UIKit

public class DayCareViewController: UIViewController {
    
    public var dayCare: DayCare? {
        didSet {
            self.reloadData()
        }
    }
    
    @IBOutlet public var trashBarButtonItem: UIBarButtonItem!
    
    @IBOutlet public weak var scrollView: UIScrollView!
    
    @IBOutlet public weak var mapView: MKMapView!
    
    @IBOutlet public weak var nameTextView: UITextView!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.refreshControl = UIRefreshControl()
        self.scrollView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        if let dayCare = self.dayCare, dayCare === User.currentUser!.dayCare {
            self.navigationItem.rightBarButtonItem = self.trashBarButtonItem
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
        self.reloadData()
    }
    
    @IBAction public func touchTrashButton(_ sender: UIBarButtonItem) {
        let title = "Are you sure?"
        let message = "You cannot undo this action."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.destroyDayCare()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        DispatchQueue.main.async {
            super.present(alertController, animated: true)
        }
    }
    
    @IBAction func callButtonWasTouched(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: self.dayCare!.phoneNumber!)!)
    }
    
    @objc private func updateData() {
        self.dayCare?.get { data, response, error in
            DispatchQueue.main.async {
                self.reloadData()
                self.scrollView.refreshControl!.endRefreshing()
            }
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.nameTextView?.text = self.dayCare?.name
            if let address = self.dayCare?.fullAddress {
                self.addressTextView?.text = address
                if let phoneNumber = self.dayCare?.formattedPhoneNumber {
                    self.addressTextView?.text += "\n\(phoneNumber)"
                }
                self.mapView?.setAddress(address)
            }
        }
    }
    
    private func destroyDayCare() {
        self.dayCare!.delete { data, response, error in
            DispatchQueue.main.async {
                super.dismiss(animated: true)
            }
        }
    }
}
