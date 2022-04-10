//
//  Device.swift
//  SwiftPods
//
//  Created by ZZJ on 2022/2/11.
//  Copyright © 2022 天天. All rights reserved.
//

import Foundation
import UIKit

class Device {
        /**
            获取当前系统版本
         */
        class var systemVersion: String {
            get {
                return UIDevice.current.systemVersion
            }
        }
        
        /**
            获取当前系统名称
         */
        static var systemName: String {
            get {
                return UIDevice.current.systemName
            }
        }
        
        /**
           当前app版本号
        */
        static var appVersion: String {
            get {
                let infoDict = Bundle.main.infoDictionary
                let currentVersion = infoDict?["CFBundleShortVersionString"]
                guard currentVersion != nil else {
                    return ""
                }
                return currentVersion as! String
            }
        }
        
        
        /**
            设备唯一标识
         */
        static var uuid: String {
            get {
                let uuid = UIDevice.current.identifierForVendor?.uuidString
                
                return uuid ?? ""
            }
            
        }
        
        static var deviceName: String {
            get {
                let name = UIDevice.current.name
                return name
            }
            
        }
    
    /**
            设置型号
         */
        static var deviceModel: String {
            get {
                var systemInfo = utsname()
                uname(&systemInfo)
                
                let machineMirror = Mirror(reflecting: systemInfo.machine)
                let identifier = machineMirror.children.reduce("") { identifier, element in

                        guard let value = element.value as? Int8, value != 0
                            else { return identifier }

                        return identifier + String(UnicodeScalar(UInt8(value)))

                    }
                
                return identifier
            }
            
        }
     
 
    static var deviceModelName: String {
            get {
                let model = self.deviceModel
                
                let hashTable: [String: String?] = [
                    "iPod5,1": "iPod Touch 5",
                    "iPod7,1": "iPod Touch 6",
                    
                    
                    "iPhone3,1": "iPhone4",
                    "iPhone3,2": "iPhone4",
                    "iPhone3,3": "iPhone4",
                    "iPhone4,1": "iPhone4s",
                    "iPhone5,1": "iPhone5",
                    "iPhone5,2": "iPhone5",
                    "iPhone5,3": "iPhone5c",
                    "iPhone5,4": "iPhone5c",
                    "iPhone6,1": "iPhone5s",
                    "iPhone6,2": "iPhone5s",
                    
                    "iPhone7,1": "iPhone6 Plus",
                    "iPhone7,2": "iPhone6",
                    "iPhone8,1": "iPhone6s",
                    "iPhone8,2": "iPhone6s Plus",
                    "iPhone8,4": "iPhoneSE",
                    
                    "iPhone9,1": "iPhone7",
                    "iPhone9,2": "iPhone 7 Plus",
                    "iPhone9,3": "iPhone 7",
                    "iPhone9,4": "iPhone 7 Plus",
                    
                    "iPhone10,1": "iPhone8",
                    "iPhone10,2": "iPhone8 Plus",
                    "iPhone10,3": "iPhoneX",
                    "iPhone10,4": "iPhone8",
                    "iPhone10,5": "iPhone8 Plus",
                    "iPhone10,6": "iPhoneX",
                    
                    "iPhone11,2": "iPhoneXS",
                    "iPhone11,6": "iPhoneXS MAX",
                    "iPhone11,8": "iPhoneXR",
                    
                    "iPhone12,1": "iPhone11",
                    "iPhone12,3": "iPhone11 ProMax",
                    "iPhone12,5": "iPhone11 Pro",
                    
                    "iPhone12,8": "iPhone SE2",
                    "iPhone13,1": "iPhone12 mini",
                    "iPhone13,2": "iPhone12",
                    "iPhone13,3": "iPhone12 Pro",
                    "iPhone13,4": "iPhone12 ProMax",
                    
                    "iPhone14,2": "iPhone13 Pro",
                    "iPhone14,3": "iPhone13 ProMax",
                    "iPhone14,4": "iPhone13 mini",
                    "iPhone14,5": "iPhone13",
                    
                    
                    
                    
                    "iPad2,1" : "iPad 2",
                    "iPad2,2" : "iPad 2",
                    "iPad2,3" : "iPad 2",
                    "iPad2,4" : "iPad 2",
                    "iPad2,5" : "iPad mini 1",
                    "iPad2,6" : "iPad mini 1",
                    "iPad2,7" : "iPad mini 1",
                    "iPad3,1" : "iPad 3",
                    "iPad3,2" : "iPad 3",
                    "iPad3,3" : "iPad 3",
                    "iPad3,4" : "iPad 4",
                    "iPad3,5" : "iPad 4",
                    "iPad3,6" : "iPad 4",
                    "iPad4,1" : "iPad Air",
                    "iPad4,2" : "iPad Air",
                    "iPad4,3" : "iPad Air",
                    "iPad4,4" : "iPad mini 2",
                    "iPad4,5" : "iPad mini 2",
                    "iPad4,6" : "iPad mini 2",
                    "iPad4,7" : "iPad mini 3",
                    "iPad4,8" : "iPad mini 3",
                    "iPad4,9" : "iPad mini 3",
                    "iPad5,1" : "iPad mini 4",
                    "iPad5,2" : "iPad mini 4",
                    "iPad5,3" : "iPad Air 2",
                    "iPad5,4" : "iPad Air 2",
                    "iPad6,3" : "iPad Pro",
                    "iPad6,4" : "iPad Pro",
                    "iPad6,7" : "iPad Pro",
                    "iPad6,8" : "iPad Pro",
                    
                    
                    "AppleTV2,1" : "Apple TV 2",
                    "AppleTV3,1" : "Apple TV 3",
                    "AppleTV3,2" : "Apple TV 3",
                    "AppleTV5,3" : "Apple TV 4",
                ]
                
                let name = hashTable[model] as? String
                
                guard name != nil else {
                    return model
                }
                
                return name ?? ""
                
            }
        }
        
        /**
           获取当前设备IP
         */
        static var ip: String {
            get {
                var addresses = [String]()
                var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
                if getifaddrs(&ifaddr) == 0 {
                    var ptr = ifaddr
                    while (ptr != nil) {
                        let flags = Int32(ptr!.pointee.ifa_flags)
                        var addr = ptr!.pointee.ifa_addr.pointee
                        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                            if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                                if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                                    if let address = String(validatingUTF8:hostname) {
                                        addresses.append(address)
                                    }
                                }
                            }
                        }
                        ptr = ptr!.pointee.ifa_next
                    }
                    freeifaddrs(ifaddr)
                }
                
                let address = addresses.first ?? "0.0.0.0"
                
                return address
            }
            
        }

        
}
