//
//  ProductObject.swift
//  storeProject
//
//  Created by Bdoor on 07/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import Foundation
import FirebaseFirestore


class ProductObject {
    
    var ID:String?
    var Stamp:TimeInterval?
    
    var Name:String?
    var Description:String?
    var Company:String?
    var Price:Double?
    var imageURLs:[String]?
    init(ID:String,Stamp:TimeInterval,Name:String,Description:String,Company:String,Price:Double,imageURLs:[String]) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.Description = Description
        self.Company = Company
        self.Price = Price
        self.imageURLs = imageURLs
    }
    init(Dictionary:[String:AnyObject]) {
        
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.Description = Dictionary["Description"] as? String
        self.Company = Dictionary["Company"] as? String
        self.Price = Dictionary["Price"] as? Double
        self.imageURLs = Dictionary["imageURLs"] as? [String]
        
        
    }
    func MakeDictionary() -> [String:AnyObject] {
        var D:[String:AnyObject] = [:]
        D["ID"] = self.ID as AnyObject
        D["Stamp"] = self.Stamp as AnyObject
        D["Name"] = self.Name as AnyObject
        D["Description"] = self.Description as AnyObject
        D["Company"] = self.Company as AnyObject
        D["Price"] = self.Price as AnyObject
        D["imageURLs"] = self.imageURLs as AnyObject
        return D
    }
    func Upload(){
        guard let id = ID else {return}; Firestore.firestore().collection("Products").document(id).setData(MakeDictionary())
        
    }
    func Remove(){
        guard let id = ID else {return}; Firestore.firestore().collection("Products").document(id).delete()
    }
}

class ProductApi{
    static func GetProduct(ID:String ,completion:@escaping(_ Product:ProductObject)->()){
    Firestore.firestore().collection("Products").document(ID).addSnapshotListener { (Snapshot:DocumentSnapshot?, Error:Error?) in
            if let data = Snapshot?.data() as [String:AnyObject]?{
                
                let New = ProductObject.init(Dictionary: data)
                completion(New)
            }
        }
        
    }
    static func GetAllProduct(completion:@escaping(_ Product:ProductObject)->()){
        Firestore.firestore().collection("Products").getDocuments { (snapshot, error) in
            if error != nil {print("error"); return}
            guard let documents = snapshot?.documents else {return}
            for P in documents{
                if let data = P.data() as [String:AnyObject]?{
                    let New = ProductObject(Dictionary: data)
                    completion(New)
                }
                
            }
            
        }
        
    }
}
