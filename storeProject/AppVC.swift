//
//  AppVC.swift
//  storeProject
//
//  Created by Bdoor on 02/06/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class AppVC:UIViewController{
    
    @IBAction func signOut(_ sender: UIButton) {
        try?Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
}
