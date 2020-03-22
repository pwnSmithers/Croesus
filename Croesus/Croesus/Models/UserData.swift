//
//  User.swift
//  Croesus
//
//  Created by Smithers on 22/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import Firebase


struct UserData {
    let ref : DatabaseReference?
    let key : String
    let firstName : String
    let lastName : String
    let userEmail : String
    let photoUrl : String

    
    
    init(key: String = "", firstName:String, lastName:String, userEmail:String, photoUrl:String) {
        self.ref = nil
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.photoUrl = photoUrl
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let userEmail = value["userEmail"] as? String,
            let photoUrl = value["photoUrl"] as? String
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.photoUrl = photoUrl
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "userEmail" : userEmail,
            "photoUrl" : photoUrl
        ]
    }
    
}
