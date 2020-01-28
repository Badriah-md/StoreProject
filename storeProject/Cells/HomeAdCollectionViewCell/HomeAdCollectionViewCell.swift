//
//  HomeAdCollectionViewCell.swift
//  storeProject
//
//  Created by Bdoor on 03/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import SDWebImage

class HomeAdCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func update(URLS:String){
        if let url = URL(string: URLS){
            imageView.sd_setImage(with: url, completed: nil)
            self.imageView.contentMode = .scaleAspectFill
            
            
        }
        
    }

}
