//
//  myProductVC.swift
//  storeProject
//
//  Created by Bdoor on 09/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit


class myProductVC: UIViewController {
    
    var myproductArray :[ProductObject] = []
    var dell = AddNewProductVC()
   
    
    
    @IBOutlet weak var myProducttableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProducttableview.delegate = self
        myProducttableview.dataSource = self
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(myProductVC.ReloadData), name: NSNotification.Name(rawValue: "ReloadData"), object: nil)
       
    }
    @objc func ReloadData(){
        self.myproductArray = []
        self.myProducttableview.reloadData()
        getData()
    }
    func getData(){
        ProductApi.GetAllProduct { (product:ProductObject) in
            self.myproductArray.append(product)
            self.myProducttableview.reloadData()
            
        }
        
    }
   
    
}
extension myProductVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myproductArray.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            myproductArray.remove(at: indexPath.row)
            self.myProducttableview.deleteRows(at: [indexPath], with: .fade)
          
        }
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let delete = deleteAction(at : indexPath)
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
//    func deleteAction(at indexPath:IndexPath)->UIContextualAction{
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//
//
//            self.myproductArray.remove(at: indexPath.row)
//            self.myProducttableview.deleteRows(at: [indexPath], with: .automatic)
//
//            completion(true)
//
//        }
//         dell.EditingProduct?.Remove()
//        return action
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyProductTableViewCell
        cell.update(Product: self.myproductArray[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = myproductArray[indexPath.row]
        performSegue(withIdentifier: "Next", sender: selectedProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? AddNewProductVC {
            if let product = sender as? ProductObject {
                next.EditingProduct = product
            }
        }
    }
}
