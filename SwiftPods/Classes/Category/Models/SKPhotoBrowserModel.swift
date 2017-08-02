//
//  SKPhotoBrowserModel.swift
//  SwiftPods
//
//  Created by Jion on 2017/8/1.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import Alamofire

class SKPhotoBrowserModel: NSObject {
    
    //图片id
    var img_id: String?
    //头条标题
    var img_title: String?
    //图片宽高
    var height: Float?
    var width: Float?
    //图片链接
    var img_url: String?
    var imgs: Array<Any>?
    
  class func alamofireFetch(url: String?, handler completionHandler: @escaping (Dictionary<String, Any>) -> Void) {
        let baseUrl = "https://api.youjuke.com/materialMall/management_interface"
        guard let url = url else {
            return
        }
        
        let otherParm = ["function_name":url,"params":["page":NSNumber.init(value: 1)]] as [String : Any]
        let jsonParm = self.getString(byObject: otherParm)
        let param:[String:Any] = ["json_msg":jsonParm]
        
        //设置无效证书访问
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        
        Alamofire.request(baseUrl, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.error == nil else {
                print(response.error.debugDescription)
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //print(utf8Text.debugDescription)
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                    completionHandler([:])
                    return
                }
                
                completionHandler(json as! Dictionary<String, Any>)
                
            }
            
        }
    }

    
}
