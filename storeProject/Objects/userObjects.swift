//
//  userObjects.swift
//  storeProject
//
//  Created by Bdoor on 07/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class userObjects{
    
    var ID :String?
    var Stamp:TimeInterval?
    var Name:String?
    var IsMale:Bool?
    var Age:Int?
    
    init(ID:String,Stamp:TimeInterval,Name:String,IsMale:Bool,Age:Int) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.IsMale = IsMale
        self.Age = Age
    }
    init(Dictionary:[String:AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.IsMale = Dictionary["IsMale"] as? Bool
        self.Age = Dictionary["Age"] as? Int
    }
    func MakeDictionary() -> [String:AnyObject] {
        var New :[String:AnyObject] = [:]
        New["ID"] = self.ID as AnyObject
        New["Stamp"] = self.Stamp as AnyObject
        New["Name"] = self.Name as AnyObject
        New["IsMale"] = self.IsMale as AnyObject
        New["Age"] = self.Age as AnyObject
        
        return New
    }
    func Upload()  {
        guard let id = self.ID else {return}
        Firestore.firestore().collection("Users").document(id).setData(MakeDictionary())
    }

   
    
}
class userAPI {
    static func GetUser(ID:String ,completion:@escaping(_ User:userObjects)->()){
        Firestore.firestore().collection("Users").document(ID).addSnapshotListener { (Snapshot:DocumentSnapshot?, Error:Error?) in
            if let data = Snapshot?.data() as [String:AnyObject]?{
               
                let New = userObjects.init(Dictionary: data)
                completion(New)
            }
        }
        
    }
}
