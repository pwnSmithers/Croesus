//
//  LoginViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButtonView: UIButton!
    
    
    @IBAction func loginButton(_ sender: Any) {
        login()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkAlreadyLoggedIn()
    }
    
    fileprivate func setupView(){
        loginButtonView.layer.cornerRadius = 8
        
    }
    
    fileprivate func checkAlreadyLoggedIn(){
        self.showLoadingAdded(to: self.view)
        guard let _ = Constants.keychain["uid"] else {
            self.hideLoading()
            return
        }
        self.hideLoading()
        self.segueToTabController()
    }
    
    fileprivate func login(){
        guard
          let email = userName.text,
          let passwordString = password.text,
          email.count > 0,
          passwordString.count > 0
          else {
            userName.checkFields(placeholder: "Please enter your email")
            password.checkFields(placeholder: "Please enter your password")
            return
        }
        self.showLoadingAdded(to: self.view)
        Auth.auth().signIn(withEmail: email, password: passwordString) { user, error in
            self.hideLoading()
            if let error = error, user == nil {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true, completion: nil)
          }
            guard let user = user else { return }
            Constants.keychain["uid"] = user.user.uid
            self.segueToTabController()
        }
    }
    
}
