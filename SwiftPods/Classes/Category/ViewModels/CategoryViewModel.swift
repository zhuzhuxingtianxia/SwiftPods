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
        let datas = [["title":"SwiftyJSON和HandyJSON"],
                     ["title":"Alamofire"],
                     ["title":"Kingfisher和SKPhotoBrowser"],
                     ["title":"SnapKit其前身是 Masonry"],
                     ["title":"RealmSwift"],
                     ["title":"RxSwift"],
                     ["title":"Charts"],
                     ["title":"CVCalendar 该日历框架有很多缺陷"],
        ]
        var models = [CategoryModel]()
        for dict in datas {
            //以下两种方式都可以转model
            models.append(CategoryModel.toModel(dic: dict))
 
//            models.append(CategoryModel.init(dict: dict))
        }
        
        completion(models)
        
    }
    
}
