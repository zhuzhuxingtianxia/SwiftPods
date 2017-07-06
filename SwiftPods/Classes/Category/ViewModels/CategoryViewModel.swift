//
//  CategoryViewModel.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/5.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryViewModel: NSObject {
    
    class func reloadSource(completion:(_ dataArray:Array<CategoryModel>)->Void) {
        let data = [["title":"SwiftyJSON"],["title":"Alamofire"],["title":"Kingfisher和SKPhotoBrowser"],["title":"RealmSwift"],["title":"RxSwift"],["title":"Charts"],]
        
        let json = JSON.init(rawValue: data)
        
        //completion(json)
    }
    
}
