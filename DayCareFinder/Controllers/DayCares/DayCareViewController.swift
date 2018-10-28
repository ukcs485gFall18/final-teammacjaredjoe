//
//  DayCareViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/16/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class DayCareViewController: UIViewController {
    
    public var dayCare: DayCare? {
        didSet {
            self.reloadData()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet public weak var nameLabel: UILabel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.refreshControl = UIRefreshControl()
        self.scrollView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        self.reloadData()
    }
    
    @IBAction func touchTrashButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Are you sure?", message: "You can not undo this action.", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.destroyDayCare()
        }))
        self.present(alertController, animated: true)
    }
    
    @objc private func updateData() {
        API.show(type: DayCare.self, id: self.dayCare!.id) { dayCare in
            self.dayCare = dayCare
            DispatchQueue.main.async {
                self.reloadData()
                self.scrollView.refreshControl!.endRefreshing()
            }
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.nameLabel?.text = self.dayCare?.name
        }
    }
    
    private func destroyDayCare() {
        API.destroy(object: self.dayCare!) { _ in
        }
    }
}
