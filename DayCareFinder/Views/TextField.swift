//
//  TextField.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/18/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

public class TextField: UITextField {
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        super.borderStyle = .none
        super.layer.backgroundColor = UIColor.darkGray.cgColor
        super.layer.shadowColor = UIColor.lightGray.cgColor
        super.layer.shadowOffset = CGSize(width: 0, height: 1)
        super.layer.shadowOpacity = 1.0
        super.layer.shadowRadius = 0.0
    }
}
