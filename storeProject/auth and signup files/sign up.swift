//
//  sign up.swift
//  storeProject
//
//  Created by Bdoor on 30/05/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class signUp: UIViewController{
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordT: UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        if confirmPasswordT.text != passwordText.text{
            return
        }
        
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
            if error == nil{
                print("welcome to our community")
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }else{
                print(error.debugDescription)
            }
        }
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
