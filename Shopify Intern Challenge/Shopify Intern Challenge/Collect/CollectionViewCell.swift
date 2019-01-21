//
//  CollectionViewCell.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-16.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 10
    }
}
