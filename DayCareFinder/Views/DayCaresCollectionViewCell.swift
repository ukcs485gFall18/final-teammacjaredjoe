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
    
    @IBOutlet public weak var imageView: UIImageView!
    
    @IBOutlet public weak var nameLabel: UILabel!
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        super.contentView.backgroundColor = UIColor.white
        super.contentView.layer.borderColor = UIColor.lightGray.cgColor
        super.contentView.layer.borderWidth = 1.0
        super.contentView.layer.cornerRadius = 10.0
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
    }
}
