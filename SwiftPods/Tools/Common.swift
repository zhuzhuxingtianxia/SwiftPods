//
//  Common.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

extension NSObject {
    func ZJClassFromString(className:String) -> NSObject.Type{
        //这里也是坑，请不要翻译oc的代码，而是去NSBundle类里面看它的api
        let appName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
        let objcName:String = appName + "." + className
        let objc = NSClassFromString(objcName)! as! NSObject.Type
        
        return objc
    }

//MARK: -- 转字符
    func getString(byObject object:Any) -> String {
        guard let data =  try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted) else{ return ""}
        guard let jsonString = String.init(data: data, encoding: String.Encoding.utf8) else {
            return ""
        }
        
        return jsonString
    }
    
}
