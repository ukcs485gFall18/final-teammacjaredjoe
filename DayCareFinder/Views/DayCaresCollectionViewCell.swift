//
//  DayCaresCollectionViewCell.swift
//  DayCareFinder
//
//  Created by Jared Payne on 9/2/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class DayCaresCollectionViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "DayCaresCollectionViewCell"
    
    @IBOutlet public weak var nameLabel: UILabel!
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
    }
}
