//
//  CategoryModel.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/5.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

//Codable扩展类型不匹配：https://www.jianshu.com/p/f4b3dce8bd6f
 //使用struct方式
 struct CategoryModel: Codable {
 public var title:String?
 
    static func toModel(dic:Dictionary<String,Any>) -> CategoryModel {
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let model = try! JSONDecoder().decode(CategoryModel.self, from: data!)
        
        return model
    }
    
 }

/*
//使用class方式
@objcMembers
class CategoryModel: NSObject {
    public var title:String?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
*/

