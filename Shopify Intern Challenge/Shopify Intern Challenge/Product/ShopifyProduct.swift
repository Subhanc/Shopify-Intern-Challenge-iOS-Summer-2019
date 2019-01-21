//
//  ShopifyProduct.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-18.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit

class ShopifyProduct {
    var id: Int?
    var title: String?
    var collection: String?
    var image: UIImage?
    var inventory: Int?
    
    
    init(myId: Int, myTitle: String, myCollection: String, myImage: UIImage, myInventory: Int?) {
        id = myId
        title = myTitle
        collection = myCollection
        image = myImage
        inventory = myInventory
    }
}
