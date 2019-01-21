//
//  ShopifyCollect.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-17.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit

class ShopifyCollect {
    
    var id: Int?
    var title: String?
    var image: UIImage?
    
    init(myId: Int, myTitle: String, myImage: UIImage) {
        id = myId
        title = myTitle
        image = myImage
    }
}
