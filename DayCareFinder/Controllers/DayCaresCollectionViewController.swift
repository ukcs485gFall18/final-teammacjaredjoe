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
        let url = URL(string: "http://localhost:3000/day_cares.json")!
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.dayCares = try! decoder.decode([DayCare].self, from: data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl!.endRefreshing()
            }
        } .resume()
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = super.collectionView.indexPathsForSelectedItems!.first!
        let navigationController = segue.destination as! UINavigationController
        let dayCareViewController = navigationController.topViewController as! DayCareViewController
        dayCareViewController.dayCare = self.dayCares[indexPath.row]
    }
}
