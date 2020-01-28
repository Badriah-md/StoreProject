//
//  forgot password.swift
//  storeProject
//
//  Created by Bdoor on 30/05/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class forgotPassword : UIViewController{
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBAction func reset(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailText.text!, completion: nil)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
