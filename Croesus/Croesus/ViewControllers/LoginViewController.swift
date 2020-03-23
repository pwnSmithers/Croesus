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
    }
    
    fileprivate func setupView(){
        loginButtonView.layer.cornerRadius = 8
        
    }
    
    fileprivate func login(){
        guard
          let email = userName.text,
          let password = password.text,
          email.count > 0,
          password.count > 0
          else {
            return
        }
        self.showLoadingAdded(to: self.view)
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            self.hideLoading()
            if let error = error, user == nil {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true, completion: nil)
          }

            self.segueToTabController()
        }
    }
    
}
