//
//  ProductVC.swift
//  storeProject
//
//  Created by Bdoor on 11/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import SDWebImage

class ProductVC: UIViewController {
    var product:ProductObject!
    
    @IBOutlet weak var productDetailView: UIView!
    override func viewDidLoad() {
        
        collectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        super.viewDidLoad()
        self.titleLabel.text = product.Name 
        self.descriptionLabel.text = product.Description
        self.priceLabel.text = (product.Price?.description ?? "") + "$"
     
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func DecreaseButton(_ sender: Any) {
    }
    @IBAction func IncreaseButton(_ sender: Any) {
    }
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func orderButton(_ sender: Any) {
    }
    
}
extension ProductVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.imageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagesCollectionViewCell
        if let imgs = self.product.imageURLs{
            cell.Update(url: imgs[indexPath.row])
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
               return CGSize(width: self.view.frame.size.width, height: collectionView.frame.size.height)
        }
    
}
