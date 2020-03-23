//
//  PresentTabController.swift
//  Croesus
//
//  Created by Smithers on 23/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func segueToTabController(){
        let story = UIStoryboard(name: "Main", bundle:nil)
        let tabbar = story.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        UIApplication.shared.windows.first?.rootViewController = tabbar
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
