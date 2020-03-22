//
//  User.swift
//  Croesus
//
//  Created by Smithers on 22/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import Firebase


struct UserData : Codable{
    let id : String?
    let firstName : String?
    let lastName : String?
    let userEmail : String?
    let photoUrl : String?

    
    
    init(id: String = "", firstName:String, lastName:String, userEmail:String, photoUrl:String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.photoUrl = photoUrl
    }
    
}
