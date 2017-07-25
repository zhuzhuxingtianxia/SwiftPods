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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        alamofireTest1()
        
        alamofireTest2()
    }
    
    func alamofireTest1() {
        let url = "https://api.youjuke.com"
        let param:[String:Any] = [:]
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).response { (response) in
            
        }
    }
    
    func alamofireTest2() {
        let url = "https://api.youjuke.com"
        let param:[String:Any] = [:]
        Alamofire.request(url, method: HTTPMethod.post, parameters: param).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
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
