//
//  sign in.swift
//  storeProject
//
//  Created by Bdoor on 30/05/1441 AH.
//  Copyright © 1441 badriah. All rights reserved.
//

import UIKit
import Firebase

class signIn:UIViewController,UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var BottomLayout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingUpKeyboardNotificaions()
        
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func signin(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (auth, error) in
            if error == nil {
                print("welcome")
                self.dismiss(animated: true, completion: nil)
            }else if error != nil || (self.email.text)!.isEmpty && (self.password.text)!.isEmpty{
                print(error.debugDescription)
                let alert = UIAlertController(title: "Error", message: "password or email is wrong", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert ,animated: true,completion: nil)
                
            }
            
        }
    }
    
}
// Keyboard height show off/ show up
extension signIn {
    
    func SettingUpKeyboardNotificaions(){
        NotificationCenter.default.addObserver(self, selector: #selector(signIn.KeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signIn.KeyboardHid(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func KeyboardShow(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
               // let keyboardHeight = ((keyboardSize.height) > 240) ? 220 :  (keyboardSize.height - 47)
               //suggestion box show
                self.BottomLayout.constant = keyboardSize.height
               
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        }
        
    }
    
    @objc func KeyboardHid(notification : NSNotification) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.BottomLayout.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    
}
