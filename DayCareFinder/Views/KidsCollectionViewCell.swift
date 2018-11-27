//
//  KidsCollectionViewCell.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/26/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class KidsCollectionViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "KidsCollectionViewCell"
    
    @IBOutlet public weak var nameLabel: UILabel!
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        super.contentView.layer.borderColor = UIColor.lightGray.cgColor
        super.contentView.layer.borderWidth = 1.0
    }
}
