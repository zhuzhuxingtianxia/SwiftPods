//
//  Reflect+Class.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/5.
//  Copyright © 2017年 天天. All rights reserved.
//

import Foundation

extension Reflect{static var classNameOfString: String {return "\(self)"}}

func ClassFromString(str: String) -> AnyClass!{

    if  var appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
        
        if appName == "" {appName = ((Bundle.main.bundleIdentifier!).characters.split{$0 == "."}.map { String($0) }).last ?? ""}
        
        var clsStr = str
        
        if !str.contain(subStr: "\(appName)."){
            clsStr = appName + "." + str
        }

        let strArr = clsStr.explode(separator: ".")
        
        var className = ""
        
        let num = strArr.count
        
        if num > 2 || strArr.contains(appName) {
            
            var nameStringM = "_TtC" + "C".repeatTimes(times: num - 2)
            
            for (_, s): (Int, String) in strArr.enumerated(){
                
                nameStringM += "\(s.characters.count)\(s)"
            }
            
            className = nameStringM
            
        }else{
           
            className = clsStr
        }
        
        let cls:AnyClass = NSClassFromString(className)!
        
        return cls
    }
    
    return nil;
}

