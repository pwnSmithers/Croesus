//
//  RootViewController.swift
//  Croesus
//
//  Created by Smithers on 27/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        print("Screen loaded")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.presentLogin()
    }

}
