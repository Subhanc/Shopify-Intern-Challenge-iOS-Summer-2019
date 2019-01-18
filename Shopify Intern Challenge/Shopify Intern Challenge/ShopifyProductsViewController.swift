//
//  ShopifyProductsViewController.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-18.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopifyProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    let cellIdentifier = "ProductCell"
    
    var myID = 0
    var items = [ShopifyProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getProductsHolder(id: myID) { result in
            if let myValue = result.value {
                self.getProductData(allId: myValue) { newResult in
                    if let productsValue = newResult.value {
                        self.items = productsValue
                        self.myTableView.reloadData()
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: UITableView funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
        cell.myTitleLabel.text = items[indexPath.item].title
        cell.myCollectionLabel.text = items[indexPath.item].collection
        cell.myImageView.image = items[indexPath.item].image
        cell.myInventoryLabel.text = String(items[indexPath.item].inventory!)
        return cell
    }
    
    // MARK:  Shopify API
    
    let ACCESS_TOKEN = "c32313df0d0ef512ca64d5b336a0d7c6"
    let PRODUCT_HOLDER_URL = "https://shopicruit.myshopify.com/admin/collects.json"
    let PRODUCT_URL = "https://shopicruit.myshopify.com/admin/products.json"
    
    func getProductsHolder(id: Int, completion: @escaping (Result<String>) -> Void) {
        let myParameters = [
            "access_token" : ACCESS_TOKEN,
            "collection_id": id
            ] as [String : Any]
        
        Alamofire.request(PRODUCT_HOLDER_URL, parameters: myParameters).responseJSON { response in
            if let myValue = response.result.value {
                let jsonValue = JSON(myValue)
                let collectsJSON = jsonValue["collects"]
                
                var productIDs = ""
                
                for (_, holder) : (String, JSON) in collectsJSON {
                    let productID = holder["product_id"].stringValue
                    productIDs += productID + ","
                }
                productIDs.removeLast()
                DispatchQueue.main.async {
                    completion(Result.success(productIDs))
                }
            }
        }
    }
    
    func getProductData(allId: String, completion: @escaping (Result<[ShopifyProduct]>) -> Void) {
        let myParameters = [
            "access_token" : ACCESS_TOKEN,
            "ids": allId
        ]
        
        Alamofire.request(PRODUCT_URL, parameters: myParameters).responseJSON { response in
            if let myValue = response.result.value {
                var productsArray = [ShopifyProduct]()
                let jsonValue = JSON(myValue)
                let productsJSON = jsonValue["products"]
                for (_, product) : (String, JSON) in productsJSON {
                    let id = product["id"].intValue
                    var titleArray = product["title"].stringValue.split(separator: " ")
                    let collection = String(titleArray.removeFirst())
                    let title = String(titleArray.joined(separator: " "))
                    let imageURL = product["image"]["src"].stringValue
                    let image = self.downloadImage(urlString: imageURL)
                    
                    var totalInventory = 0
                    let variantsJSON = product["variants"]
                    for (_, variant) : (String, JSON) in variantsJSON {
                        let inventory = variant["inventory_quantity"].intValue
                        totalInventory += inventory
                    }
                    let myProduct = ShopifyProduct(myId: id, myTitle: title, myCollection: collection, myImage: image, myInventory: totalInventory)
                    productsArray.append(myProduct)
                }
                DispatchQueue.main.async {
                    completion(Result.success(productsArray))
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
