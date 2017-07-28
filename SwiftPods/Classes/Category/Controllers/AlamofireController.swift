//
//  AlamofireController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
            openPhotoAlbum()
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

//MARK : 使用相册
    func openPhotoAlbum() {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) else {
            print("相册不可用")
            return
        }
       let imgePicker = UIImagePickerController.init()
        imgePicker.delegate = self
        imgePicker.sourceType = .photoLibrary
        imgePicker.setEditing(true, animated: true)
        present(imgePicker, animated: true) { 
            
        }
    }
    
    //上传资源
    func alamofireUpload(image:UIImage?) {
        let url = "https://preapi.51youjuke.com/materialMall/management_interface"
        let otherParm = ["function_name":"upload_mall_order","params":["area_id":"726","distributor_id":"15","mall_id":"1","order_date":"2017-07-28","pay_type":"1","user_id":"52253","total_price":"888","order_no":NSNumber.init(value: 2004)]] as [String : Any]
        let jsonParm = getString(byObject: otherParm)
        let param:[String:String] = ["json_msg":jsonParm]
        
        //设置无效证书访问
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let _image = image {
                if let imageData = UIImageJPEGRepresentation(_image, 0.3) {
                    //let path = self.getCachesPath()
                   // multipartFormData.append(imageData, withName: "file")
                    multipartFormData.append(imageData, withName: "file", fileName: "\(NSDate.init())" + ".png", mimeType: "image/png")

                }
            }
            
            for (key, value) in param {
               
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
               
            }
            
        }, to: url) { (formDataEncodingResult) in
            switch  formDataEncodingResult{
                case .success(let uploadData, _, _):
                    uploadData.responseJSON(completionHandler: { (dataResponse) in
                        guard dataResponse.error == nil else {
                            print(dataResponse.error.debugDescription)
                            return
                        }
                        
                        if let data = dataResponse.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Upload: \(utf8Text)")
                            let jsonData = JSON.init(parseJSON: utf8Text)
                            if jsonData["status"] == 200 {
                                print("成功")
                            }else{
                                print(jsonData["message"])
                            }
                        }
                        
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

extension AlamofireController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage]
        let referenceURL = info[UIImagePickerControllerReferenceURL]!
        print(referenceURL)
        
        alamofireUpload(image: img as? UIImage)
        dismiss(animated: true) { 
            
        }
    }
    
    
}


