//
//  DayCaresCollectionViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 9/2/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class DayCaresCollectionViewController: UICollectionViewController {
    
    public typealias CellType = DayCaresCollectionViewCell
    
    public var dayCares: [DayCare] = []
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        super.collectionView.refreshControl = UIRefreshControl()
        super.collectionView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        self.updateData()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dayCares.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as! CellType
        let dayCare = self.dayCares[indexPath.row]
        if let url = dayCare.imageUrl {
            URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data!)!
                    }
                }
            } .resume()
        }
        DispatchQueue.main.async {
            cell.nameLabel.text = dayCare.name
        }
        return cell
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MyDayCare":
            self.prepareForMyDayCare(segue: segue, sender: sender)
        case "Show":
            self.prepareForShow(segue: segue, sender: sender)
        case "User":
            self.prepareForUser(segue: segue, sender: sender)
        default:
            break
        }
    }
    
    private func prepareForMyDayCare(segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! DayCareViewController
        viewController.dayCare = User.currentUser!.dayCare
    }
    
    private func prepareForShow(segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! DayCareViewController
        let indexPath = super.collectionView.indexPathsForSelectedItems!.first!
        viewController.dayCare = self.dayCares[indexPath.row]
    }
    
    private func prepareForUser(segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async {
            super.navigationController!.title = "User"
            self.menuBarButtonItem.title = "Close"
        }
    }
    
    @IBAction public func unwindToDayCaresCollectionViewController(segue: UIStoryboardSegue) {
        DispatchQueue.main.async {
            super.navigationController!.title = "Day Cares"
            self.menuBarButtonItem.title = "Menu"
        }
        self.updateData()
        if segue.identifier == "MyDayCare" {
            DispatchQueue.main.async {
                super.performSegue(withIdentifier: "MyDayCare", sender: nil)
            }
        }
    }
    
    @objc private func updateData() {
        DayCare.all { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                self.dayCares = API.decode([DayCare].self, from: data!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.refreshControl!.endRefreshing()
                }
            }
        }
    }
}
