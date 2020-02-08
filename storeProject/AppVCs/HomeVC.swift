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
    var AdArray: [AdsObject] = []
    
    var productsArray: [ProductObject] = []
    var DealProdArray:[String] = ["",""]
    var scrollTimer = Timer()
    
    @IBOutlet weak var Deals: UIButton!
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUpCollectionView()
       getData()
     
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        flash()
    }
    func flash(){
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.1
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = .infinity
           Deals.layer.add(flash,forKey:nil)
       }
    func getData(){
        ProductApi.GetAllProduct { (product) in
            self.productsArray.append(product)
            self.productCollectionView.reloadData()
        }
        AdsApi.GetAllAd { (Ads) in
            self.AdArray.append(Ads)
            self.collectionview.reloadData()
        }
    }
   
      
        
    @IBAction func DealsButton(_ sender: UIButton) {
       
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
            return AdArray.count
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
           
            cell.update(AD: AdArray[indexPath.row])
            var rowIndex = indexPath.row
            let numberOfRecords:Int = self.AdArray.count - 1
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            ProductApi.GetProduct(ID: self.AdArray[indexPath.row].ID!) { (product) in
                 self.performSegue(withIdentifier: "showProduct", sender: product)
            }
           
        }else if collectionView.tag == 1{
            self.performSegue(withIdentifier: "showProduct", sender: self.productsArray[indexPath.row])
            
        }else if collectionView.tag == 2{
            self.performSegue(withIdentifier: "showProduct", sender: self.DealProdArray[indexPath.row])
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let product = sender as? ProductObject{
            if let next = segue.destination as? ProductVC{
                next.product = product
            }
        }
    }
    @objc func startTimer(theTimer:Timer)  {
        UIView.animate(withDuration: 0.0, delay: 0, options: .curveEaseOut, animations: {
            self.collectionview.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: true)
        }, completion: nil)
    }
  
}
