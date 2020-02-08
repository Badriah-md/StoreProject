import Foundation
import FirebaseFirestore


class AdsObject {
    
    var ID:String?
    var Stamp:TimeInterval?
    var imageURL:String?
    var ProductID:String?
    init(ID:String,Stamp:TimeInterval,imageURL:String,ProductID:String) {
        self.ID = ID
        self.Stamp = Stamp
        self.imageURL = imageURL
        self.ProductID = ProductID
    }
    init(Dictionary:[String:AnyObject]) {
        
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.imageURL = Dictionary["imageURL"] as? String
        self.ProductID = Dictionary["ProductID"] as? String
        
        
    }
    func MakeDictionary() -> [String:AnyObject] {
        var D:[String:AnyObject] = [:]
        D["ID"] = self.ID as AnyObject
        D["Stamp"] = self.Stamp as AnyObject
        D["imageURL"] = self.imageURL as AnyObject
        D["ProductID"] = self.ProductID as AnyObject
        return D
    }
    func Upload(){
        guard let id = ID else {return}; Firestore.firestore().collection("Ads").document(id).setData(MakeDictionary())
        
    }
    func Remove(){
        guard let id = ID else {return}; Firestore.firestore().collection("Ads").document(id).delete()
    }
}

class AdsApi{
    static func Get(ID:String ,completion:@escaping(_ Ad:AdsObject)->()){
    Firestore.firestore().collection("Ads").document(ID).addSnapshotListener { (Snapshot:DocumentSnapshot?, Error:Error?) in
            if let data = Snapshot?.data() as [String:AnyObject]?{
                
                let New = AdsObject.init(Dictionary: data)
                completion(New)
            }
        }
        
    }
    static func GetAllAd(completion:@escaping(_ Ad:AdsObject)->()){
        Firestore.firestore().collection("Ads").getDocuments { (snapshot, error) in
            if error != nil {print("error"); return}
            guard let documents = snapshot?.documents else {return}
            for P in documents{
                if let data = P.data() as [String:AnyObject]?{
                    let New = AdsObject(Dictionary: data)
                    completion(New)
                }
                
            }
            
        }
        
    }
}
