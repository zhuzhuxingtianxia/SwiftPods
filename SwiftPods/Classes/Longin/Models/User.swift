//
//  User.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/13.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

enum Gender: String {
    case male = "male"
    case female = "female"
}

class Users: NSObject {
    let name: String? = nil
    let email: String? = nil
    let age: Int? = nil
    let gender: Gender? = nil
    
}

struct User {
    let name: String
    let email: String
    let age: Int
    let gender: Gender
    
}

extension User {
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let email = json["email"] as? String,
            let age = json["age"] as? Int,
            let genderString = json["gender"] as? String,
            let gender = Gender(rawValue: genderString) else {
                return nil
        }
        self.init(name: name, email: email, age: age, gender: gender)
    }
}

