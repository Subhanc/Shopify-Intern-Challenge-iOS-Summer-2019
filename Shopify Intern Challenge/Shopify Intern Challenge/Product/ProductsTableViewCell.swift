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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
