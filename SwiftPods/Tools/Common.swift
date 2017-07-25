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

    
}
