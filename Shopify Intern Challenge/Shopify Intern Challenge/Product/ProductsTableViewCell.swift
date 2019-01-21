//
//  ProductsTableViewCell.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-18.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myInventoryLabel: UILabel!
    @IBOutlet weak var myCollectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
        //self.layer.cornerRadius = 10
        self.separatorInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
