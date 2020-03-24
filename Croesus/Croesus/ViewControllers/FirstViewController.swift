//
//  FirstViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FirstViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserProfile()
    }


    fileprivate func getUserProfile(){
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "uid"){
         FIRFirestoreService.shared.getUserProfile(uid: uid)
        }
        
    }
}

