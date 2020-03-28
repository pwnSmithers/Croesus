//
//  SecondViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import UIKit
import ResearchKit
class SecondViewController: UIViewController {

    @IBAction func presentButton(_ sender: Any) {
        logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

  
    fileprivate func logout(){
    //to logout, delete Firebase uid from Keychain
        do {
            try Constants.keychain.remove("uid")
            //redirect to loginPage
            self.presentLogin()
        } catch let error {
            print("error: \(error)")
        }
    }
}


