//
//  AlamofireController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireController: UIViewController {

    let segment = { () -> UISegmentedControl in 
        let segment = UISegmentedControl(items:["response","responseJSON","invalidCertificates"])
        segment.frame = CGRect.init(x: 10, y: 20, width: ZJScreenWidth - 20, height: 40)
        segment.addTarget(self, action: #selector(AlamofireController.segmentAction(sender:)), for: UIControlEvents.valueChanged)
        return segment
    }()
    
    let segment1 = { () -> UISegmentedControl in
        let segment = UISegmentedControl(items:["responseString","responseData","Upload"])
        segment.frame = CGRect.init(x: 10, y: 80, width: ZJScreenWidth - 20, height: 40)
        segment.addTarget(self, action: #selector(AlamofireController.segmentClick(sender:)), for: UIControlEvents.valueChanged)
        return segment
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        view.addSubview(segment)
        
        view.addSubview(segment1)
    }
    
    func segmentAction(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            alamofireTest1()
            case 1:
            alamofireTest2(invalidCertificates: true)
            case 2:
            alamofireTest2(invalidCertificates: false)
        default:break
        }
    }
    func segmentClick(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            alamofireTest3()
        case 1:
            alamofireTest4()
        case 2:
            alamofireUpload()
        default:break
        }
    }

    
    func alamofireTest1() {
        let url = "https://api.youjuke.com/materialMall/management_interface"
    
        let otherParm = ["function_name":"message_count","params":["uid":"52225"]] as [String : Any]
        let jsonParm = getString(byObject: otherParm)
        let param:[String:Any] = ["json_msg":jsonParm]
        
        //设置无效证书访问
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).response { (response) in
            guard response.error == nil else {
                print(response.error.debugDescription)
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data1: \(utf8Text)")
            }
        }
    }
    
    func alamofireTest2(invalidCertificates allow:Bool) {
        let url = "https://preapi.51youjuke.com/materialMall/management_interface"
        
        let otherParm = ["function_name":"message_count","params":["uid":"52225"]] as [String : Any]
        let jsonParm = getString(byObject: otherParm)
        let param:[String:Any] = ["json_msg":jsonParm]
        
        if allow {
            //设置无效证书访问
            let manager = SessionManager.default
            manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        }
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param).responseJSON { (response) in
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            guard response.result.isSuccess == true else {
                print(response.result.debugDescription)
                return
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data2: \(utf8Text)")
            }
        }
    }
    
    func alamofireTest3() {
        let url = "https://preapi.51youjuke.com/materialMall/management_interface"
        
        let otherParm = ["function_name":"message_count","params":["uid":"52225"]] as [String : Any]
        let jsonParm = getString(byObject: otherParm)
        let param:[String:Any] = ["json_msg":jsonParm]
        
        //设置无效证书访问
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data3: \(utf8Text)")
            }
        }
    }
    
    func alamofireTest4() {
        let url = "https://preapi.51youjuke.com/materialMall/management_interface"
        
        let otherParm = ["function_name":"message_count","params":["uid":"52225"]] as [String : Any]
        let jsonParm = getString(byObject: otherParm)
        let param:[String:Any] = ["json_msg":jsonParm]
        
        //设置无效证书访问
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data4: \(utf8Text)")
            }
        }
    }


    
    func alamofireUpload() {
        let url = "https://api.youjuke.com"
        let image = UIImage(named: "image.png")
        let param:[String:AnyObject] = [:]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let _image = image {
                if let imageData = UIImageJPEGRepresentation(_image, 0.5) { multipartFormData.append(imageData, withName: "file")
                }
            }
            
            for (key, value) in param {
                multipartFormData.append((value.stringValue).data(using: String.Encoding.utf8)!, withName: key)
               
            }
            
        }, to: url) { (formDataEncodingResult) in
            switch  formDataEncodingResult{
                case .success(let uploadData, _, _):
                    uploadData.responseJSON(completionHandler: { (dataResponse) in
                         print("Result: \(dataResponse.result)")
                    })
                case .failure(let encodingError):
                      print(encodingError)
               
            }
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
