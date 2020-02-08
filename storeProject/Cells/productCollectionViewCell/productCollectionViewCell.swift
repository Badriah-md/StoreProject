//
//  productCollectionViewCell.swift
//  storeProject
//
//  Created by Bdoor on 04/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit


class productCollectionViewCell: UICollectionViewCell {

   
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    func update(Product:ProductObject){
        self.Name.text = Product.Name
        self.Price.text = Product.Price?.description
        guard let imgString = Product.imageURLs?[0],let url = URL(string: imgString) else {return}
        self.imageview.sd_setImage(with: url, completed: nil)
    }
    
}
