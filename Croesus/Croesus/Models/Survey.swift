//
//  Survey.swift
//  Croesus
//
//  Created by Smithers on 27/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation

struct Survey : Codable{
    let question : String
    let answer : String
    let fullNames : String
    let email : String
    
    init(question : String, answer : String, fullNames : String, email : String) {
        self.question = question
        self.answer = answer
        self.fullNames = fullNames
        self.email = email
    }
}

