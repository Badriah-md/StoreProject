//
//  HomeVC.swift
//  storeProject
//
//  Created by Bdoor on 03/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit

class HomeVC:UIViewController {
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var Array = [
    "https://cdn.dribbble.com/users/1171505/screenshots/4886597/world_in_hands-800x600-01.png",
    "https://cdn.dribbble.com/users/1272091/screenshots/6490294/home.jpg",
    "https://cdn.dribbble.com/users/1027942/screenshots/5938356/el-paso_2x.png",
    "https://cdn.dribbble.com/users/257709/screenshots/6398360/shop__2__2x.png"
    ]
    
    var productsArray: [String] = ["","",""]
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUpCollectionView()
    }
        
    
}


//collection view code
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
    
    func settingUpCollectionView(){
        collectionview.dataSource = self;collectionview.delegate = self
        productCollectionView.dataSource = self ; productCollectionView.delegate = self
        collectionview.register(UINib.init(nibName: "HomeAdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        productCollectionView.register(UINib.init(nibName: "productCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
                   
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 1{
        return UIEdgeInsets (top: 5, left: 5, bottom: 5, right: 5)
        }
        return UIEdgeInsets()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return CGSize(width: self.view.frame.size.width, height: collectionView.frame.size.height)
            
        }else if collectionView.tag == 1{
            return CGSize(width: collectionView.frame.size.height / 1.7, height: collectionView.frame.size.height)
        }
        return CGSize()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return Array.count
        }else if collectionView.tag == 1{
            return productsArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeAdCollectionViewCell
           
            cell.update(URLS: Array[indexPath.row])
            return cell
        }else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! productCollectionViewCell
            
         
            return cell
            
        }
        
        return UICollectionViewCell()
        
    }
    
    
}
