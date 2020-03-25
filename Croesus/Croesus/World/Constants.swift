//
//  Constants.swift
//  Croesus
//
//  Created by Smithers on 25/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import KeychainAccess
struct Constants {
    //Global constants go here
    static let keychain = Keychain(service: "com.bulamu.croesus")
    static let profileImageNotificationKey = "co.smithers.profilepicture"
    static let profilePicURLNotificationKey = "co.smithers.profpicurl"
    
}
