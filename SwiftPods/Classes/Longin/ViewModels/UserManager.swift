//
//  UserManager.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/13.
//  Copyright © 2017年 天天. All rights reserved.
//  http://draveness.me/mvx-model.html

import Foundation
import Alamofire

//MARK --命令式
final class UserManager {
    static let baseURL = "http://localhost:3000"
    static let usersBaseURL = "\(baseURL)/users"
    
    static func allUsers(completion: @escaping ([User]) -> ()) {
        let url = "\(usersBaseURL)"
        Alamofire.request(url).responseJSON { response in
            if let jsons = response.result.value as? [[String: Any]] {
                let users = Users.dcObjectArrayWithKeyValuesArray(jsons as NSArray)
                completion(users as! [User])
            }
        }
    }
    
    static func user(id: Int, completion: @escaping (User) -> ()) {
        let url = "\(usersBaseURL)/\(id)"
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let user = User(json: json) {
                completion(user)
            }
        }
    }
}
//举例
/*
UserManager.user(id: 1) { user in
    self.nameLabel.text = user.name
    self.emailLabel.text = user.email
    self.ageLabel.text = "\(user.age)"
    self.genderLabel.text = user.gender.rawValue
}
*/
//MARK --声明式

protocol AbstractRequest {
    var requestURL: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}
extension AbstractRequest {
    func start(completion: @escaping (Any) -> Void) {
        Alamofire.request(requestURL, method: self.method).responseJSON { response in
            if let json = response.result.value {
                completion(json)
            }
        }
    }
}

final class AllUsersRequest: AbstractRequest {
    let requestURL = "http://localhost:3000/users"
    let method = HTTPMethod.get
    let parameters: Parameters? = nil
}

final class FindUserRequest: AbstractRequest {
    let requestURL: String
    let method = HTTPMethod.get
    let parameters: Parameters? = nil
    
    init(id: Int) {
        self.requestURL = "http://localhost:3000/users/\(id)"
    }
}

//举例 
/*
FindUserRequest(id: 1).start { json in
    if let json = json as? [String: Any],
        let user = User(json: json) {
        print(user)
    }
}
*/


