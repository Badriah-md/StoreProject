//
//  sign in.swift
//  storeProject
//
//  Created by Bdoor on 30/05/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class signIn:UIViewController{
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        subscribeTKeyboardNotifications()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapgesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signIn.keyboardhide))
        
        view.addGestureRecognizer(tapgesture)
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func signin(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (auth, error) in
            if error == nil {
                print("welcome")
            }else{
                print(error.debugDescription)
            }
            
        }
    }
    @objc func keyboardWillShow(_ notification:Notification){
        if email.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    
    func subscribeTKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    @objc func keyboardhide(){
        view.endEditing(true)
    }
}
