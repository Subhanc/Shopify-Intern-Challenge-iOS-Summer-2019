//
//  ShopifyCollectViewController.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-16.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopifyCollectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var items = [ShopifyCollect]()
    @IBOutlet var myCollectionView: UICollectionView!
    var currentID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // non multithreaded: self.items = getCollectionData()
        getCollectionData { result in
            if let myCollection = result.value {
                self.items = myCollection
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productSeque" {
            let destinationController = segue.destination as! ShopifyProductsViewController
            destinationController.myID = currentID
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.myLabel.text = items[indexPath.item].title
        cell.myImageView.image = items[indexPath.item].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentID = items[indexPath.item].id!
    }
    
    // MARK: HTTP Helper Functions

    let ACCESS_TOKEN = "c32313df0d0ef512ca64d5b336a0d7c6"
    let COLLECTIONS_URL = "https://shopicruit.myshopify.com/admin/custom_collections.json?"
    
    // Shopify API Call helper func
    func getCollectionData(completion: @escaping (Result<[ShopifyCollect]>) -> Void) {
        let shopifyParameters = [
            "access_token" : ACCESS_TOKEN
        ]
        
        Alamofire.request(COLLECTIONS_URL, parameters: shopifyParameters).responseJSON { response in
            if let value = response.result.value {
                var shopifyCollections = [ShopifyCollect]()
                
                let jsonValue = JSON(value)
                let customCollectionsJSON = jsonValue["custom_collections"]
                
                for (_, collection) : (String, JSON) in customCollectionsJSON {
                    let id = collection["id"].intValue
                    let title = collection["title"].stringValue
                    let imageURL = collection["image"]["src"].stringValue
                    
                    let image = self.downloadImage(urlString: imageURL)
                    
                    let shopifyCollect = ShopifyCollect(myId: id, myTitle: title, myImage: image)
                    shopifyCollections.append(shopifyCollect)
                }
                // return shopifyCollections if not multithreaded with closures
                DispatchQueue.main.async {
                    completion(Result.success(shopifyCollections))
                }
            }
        }
    }
    
    
    // Download images helper func
    func downloadImage(urlString: String) -> UIImage  {
        let url = URL(string: urlString)
        let imageData = try? Data(contentsOf: url!)
        if imageData != nil {
            return UIImage(data: imageData!)!
        } else {
            return UIImage()
        }
    }
}

