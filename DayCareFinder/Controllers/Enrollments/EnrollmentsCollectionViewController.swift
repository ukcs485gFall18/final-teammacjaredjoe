//
//  EnrollmentsCollectionViewController.swift
//  DayCareFinder
//
//  Created by Mac's Book on 12/1/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class EnrollmentsCollectionViewController: UICollectionViewController {
    
    public typealias CellType = KidsCollectionViewCell
    
    public var dayCare: DayCare!
    
    public var kids: [Kid] = []
    
    //load page
    public override func viewDidLoad() {
        //super calls the parent classes' method
        super.viewDidLoad()
        super.collectionView.refreshControl = UIRefreshControl()
        super.collectionView.refreshControl!.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        self.updateData()

    }
    
    //return kids count
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.kids.count
    }
    
    //path to specific kid and return cell of the kid
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as! CellType
        let kid = self.kids[indexPath.row]
        cell.nameLabel.text = kid.name!
        return cell
    }
    
    //unwind segue
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let enrollment = Enrollment()
        enrollment.dayCareId = self.dayCare.id
        enrollment.kidId = self.kids[indexPath.row].id
        enrollment.post { data, response, error in
            //201 is a response code for created
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                DispatchQueue.main.async {
                    //only happens if successful
                    super.performSegue(withIdentifier: "Show", sender: nil)
                }
            }
        }
    }
    
    //update and refresh page
    @objc private func updateData() {
        User.currentUser!.getKids() { data, response, error in
            self.kids = User.currentUser!.kids ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl!.endRefreshing()
            }
        }
    }
    
}
