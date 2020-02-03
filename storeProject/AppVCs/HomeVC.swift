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
    
    @IBOutlet weak var DealsCollectionView: UICollectionView!
    var Array = [
    "https://cdn.dribbble.com/users/1171505/screenshots/4886597/world_in_hands-800x600-01.png",
    "https://cdn.dribbble.com/users/1272091/screenshots/6490294/home.jpg",
    "https://cdn.dribbble.com/users/1027942/screenshots/5938356/el-paso_2x.png",
    "https://cdn.dribbble.com/users/257709/screenshots/6398360/shop__2__2x.png"
    ]
    
    var productsArray: [ProductObject] = []
    var DealProdArray:[String] = ["",""]
    var scrollTimer = Timer()
    
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUpCollectionView()
       getData()
   
        
        
       
    }
    func getData(){
        ProductApi.GetAllProduct { (product) in
            self.productsArray.append(product)
            self.productCollectionView.reloadData()
        }
    }
        
    @IBAction func DealsButton(_ sender: UIButton) {
        sender.flash()
    }
    
}


//collection view code
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
    
    func settingUpCollectionView(){
        collectionview.dataSource = self;collectionview.delegate = self
        productCollectionView.dataSource = self ; productCollectionView.delegate = self
        DealsCollectionView.dataSource = self ; DealsCollectionView.delegate = self
        collectionview.register(UINib.init(nibName: "HomeAdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        productCollectionView.register(UINib.init(nibName: "productCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        DealsCollectionView.register(UINib.init(nibName: "productCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
                   
        
    }
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return CGSize(width: self.view.frame.size.width, height: collectionView.frame.size.height)
            
        }else if collectionView.tag == 1{
            return CGSize(width: collectionView.frame.size.height / 1.7, height: collectionView.frame.size.height)
        }else if collectionView.tag == 2{
            return CGSize(width: collectionView.frame.size.height / 1.4, height: collectionView.frame.size.height)
        }
        return CGSize()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return Array.count
        }else if collectionView.tag == 1{
            return productsArray.count
        }else if collectionView.tag == 2{
            return DealProdArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeAdCollectionViewCell
           
            cell.update(URLS: Array[indexPath.row])
            var rowIndex = indexPath.row
            let numberOfRecords:Int = self.Array.count - 1
            if(rowIndex < numberOfRecords){
                rowIndex = (rowIndex+1)
            }else{
                rowIndex = 0
            }
            scrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(HomeVC.startTimer(theTimer:)), userInfo: rowIndex, repeats: false)
            return cell
        }else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! productCollectionViewCell
            cell.update(Product: productsArray[indexPath.row])
         
            return cell
            
        }else if collectionView.tag == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! productCollectionViewCell
            
         
            return cell
            
        }
        
        return UICollectionViewCell()
        
    }
    @objc func startTimer(theTimer:Timer)  {
        UIView.animate(withDuration: 0.0, delay: 0, options: .curveEaseOut, animations: {
            self.collectionview.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: true)
        }, completion: nil)
    }
    
    
}
extension UIButton{
    
    func flash(){
    let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.1
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           layer.add(flash,forKey:nil)
    }
}
