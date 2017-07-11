//
//  CategoryViewModel.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/5.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class CategoryViewModel: NSObject {
    
    class func reloadSource(completion:(_ dataArray:Array<CategoryModel>)->Void) {
        let data = [["title":"SwiftyJSON"],["title":"Alamofire"],["title":"Kingfisher和SKPhotoBrowser"],["title":"RealmSwift"],["title":"RxSwift"],["title":"Charts"],]
        var models = [CategoryModel]()
        for dict in data {
            
            models.append(CategoryModel(dict: dict))
        }
        
        completion(models)
        
    }
    
}
