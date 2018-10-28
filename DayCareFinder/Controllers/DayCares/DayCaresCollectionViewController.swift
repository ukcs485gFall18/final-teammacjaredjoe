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
        cell.nameLabel.text = dayCare.name
        return cell
    }
    
    @objc public func updateData() {
        API.index(type: DayCare.self) { dayCares in
            self.dayCares = dayCares ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl!.endRefreshing()
            }
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show" {
            let indexPath = super.collectionView.indexPathsForSelectedItems!.first!
            let dayCareViewController = segue.destination as! DayCareViewController
            dayCareViewController.dayCare = self.dayCares[indexPath.row]
        }
    }
    
    @IBAction public func unwindToDayCaresCollectionViewController(segue: UIStoryboardSegue) {
        self.updateData()
    }
}
