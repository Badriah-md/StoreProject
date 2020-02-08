//
//  ImagesCollectionViewCell.swift
//  storeProject
//
//  Created by Bdoor on 12/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import SDWebImage

class ImagesCollectionViewCell: UICollectionViewCell {

   

    @IBOutlet weak var imageView: UIImageView!
    
    
    func Update(url:String){
        guard let Url = URL(string: url) else {return}
        self.imageView.sd_setImage(with: Url, completed: nil)
        self.imageView.contentMode = .scaleAspectFill
    }
    func Update(image:UIImage){
        self.imageView.image = image
    }
}
