//
//  LoginViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButtonView: UIButton!
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        loginButtonView.layer.cornerRadius = 8
        
    }
    
}
