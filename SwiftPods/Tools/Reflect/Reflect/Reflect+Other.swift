//
//  Reflect+Common.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/5.
//  Copyright © 2017年 天天. All rights reserved.
//

import Foundation



extension Reflect {
    
    override var description: String {
    
        let pointAddr = NSString(format: "%p",unsafeBitCast(self, to: Int.self)) as String
        
        var printStr = self.classNameString + " <\(pointAddr)>: " + "\r{"
        
        self.properties { (name, type, value) -> Void in
            
            if type.isArray {
                
                printStr += "\r\r['\(name)']: \(value)"
                
            }else{
                
                printStr += "\r\(name): \(value)"
            }
        }
    
        printStr += "\r}"
        
        return printStr
    }
}



extension String{
    
    func contain(subStr: String) -> Bool {return (self as NSString).range(of: subStr).length > 0}
    
    func explode (separator: Character) -> [String] {
        
        
        return self.split(whereSeparator: { (element) -> Bool in

            return element == separator
        }).map { String($0) }
        
        
    }
    
    func replacingOccurrencesOfString(target: String, withString: String) -> String{
        return (self as NSString).replacingOccurrences(of: target, with: withString)
    }
    
    func deleteSpecialStr()->String{
    
        return self.replacingOccurrencesOfString(target: "Optional<", withString: "").replacingOccurrencesOfString(target: ">", withString: "")
    }
    
    var floatValue: Float? {return NumberFormatter().number(from: self)?.floatValue}
    var doubleValue: Double? {return NumberFormatter().number(from: self)?.doubleValue}
    
    func repeatTimes(times: Int) -> String{
        
        var strM = ""
        
        for _ in 0..<times {
            strM += self
        }
        
        return strM
    }
}
