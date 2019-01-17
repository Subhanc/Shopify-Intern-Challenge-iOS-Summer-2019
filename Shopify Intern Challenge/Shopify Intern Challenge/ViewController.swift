//
//  ViewController.swift
//  Shopify Intern Challenge
//
//  Created by Subhan Chaudhry on 2019-01-16.
//  Copyright © 2019 Subhan Chaudhry. All rights reserved.
//

import UIKit

let temp: String = "http://www.petsworld.in/blog/wp-content/uploads/2014/09/cat.jpg"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var items = [ShopifyCollect]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let item1 = ShopifyCollect(myTitle: "Hello World", myImage: downloadImage(urlString: temp))
        items.append(item1)
        items.append(item1)
        items.append(item1)
        items.append(item1)
        items.append(item1)
    }
    
    func downloadImage(urlString: String) -> UIImage  {
        let url = URL(string: urlString)
        let imageData = try? Data(contentsOf: url!)
        if imageData != nil {
            return UIImage(data: imageData!)!
        } else {
            return UIImage()
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
}

