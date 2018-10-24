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
    
    @objc private func updateData() {
        let url = URL(string: "http://localhost:3000/day_cares/\(self.dayCare!.id).json")!
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.dayCare = try! decoder.decode(DayCare.self, from: data)
            DispatchQueue.main.async {
                self.reloadData()
                self.scrollView.refreshControl!.endRefreshing()
            }
        } .resume()
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.nameLabel?.text = self.dayCare?.name
        }
    }
}
