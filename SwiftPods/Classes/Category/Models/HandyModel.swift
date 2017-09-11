//
//  HandyModel.swift
//  SwiftPods
//
//  Created by Jion on 2017/9/11.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import HandyJSON

//官方示例：
enum Grade: Int, HandyJSONEnum {
    case One = 1
    case Two = 2
    case Three = 3
}

enum Genders: String, HandyJSONEnum {
    case Male = "Male"
    case Female = "Female"
}

struct Teacher: HandyJSON {
    var name: String?
    var age: Int?
    var height: Int?
    var gender: Genders?
}

struct Subject: HandyJSON {
    var name: String?
    var id: Int64?
    var credit: Int?
    var lessonPeriod: Int?
}

class Student: HandyJSON {
    var id: String?
    var name: String?
    var age: Int?
    var grade: Grade = .One
    var height: Int?
    var gender: Gender?
    var className: String?
    var teacher: Teacher = Teacher()
    var subjects: [Subject]?
    var seat: String?
    
    required init() {}
}
//model要求实现HandyJSON协议
class HandyModel: HandyJSON {

    var name: String?
    var age: Int?
    var mobile: String?
    
    required init() {
        
    }
}

 
