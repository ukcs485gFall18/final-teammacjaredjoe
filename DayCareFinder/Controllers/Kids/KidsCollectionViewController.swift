//
//  KidsCollectionViewController.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/25/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class KidsCollectionViewController: UICollectionViewController {
    
    public typealias CellType = KidsCollectionViewCell
    
    private var kids: [Kid] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        super.collectionView.refreshControl = UIRefreshControl()
        super.collectionView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        self.updateData()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.kids.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as! CellType
        let kid = self.kids[indexPath.row]
        cell.nameLabel.text = kid.name!
        return cell
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Show":
            self.prepareForShow(segue: segue, sender: sender)
        default:
            break
        }
    }
    
    private func prepareForShow(segue: UIStoryboardSegue, sender: Any?) {
        let kidViewController = segue.destination as! KidViewController
        let indexPath = super.collectionView.indexPathsForSelectedItems!.first!
        kidViewController.kid = self.kids[indexPath.row]
    }
    
    @objc private func updateData() {
        User.currentUser!.getKids() { data, response, error in
            self.kids = User.currentUser!.kids ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl!.endRefreshing()
            }
        }
    }
    
    @IBAction public func unwindToKidsCollectionViewController(segue: UIStoryboardSegue) {
        self.updateData()
    }
    
    func UICollectionView(_ UICollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.kids.count == 0) {
            UICollectionView.setEmptyMessage("You do not currently have any children registered")
        } else {
            UICollectionView.restore()
        }
        
        return self.kids.count
    }}
