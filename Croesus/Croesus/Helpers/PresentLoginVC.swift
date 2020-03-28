//
//  PresentLoginVC.swift
//  Croesus
//
//  Created by Smithers on 28/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func presentLogin(){
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController {
              self.present(loginVC, animated: true, completion: nil)
          }
    }
}
