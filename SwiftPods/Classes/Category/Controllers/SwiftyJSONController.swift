//
//  SwiftyJSONController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class SwiftyJSONController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        swiftJSON()
        handyJSON()
    }

    func swiftJSON() {
        let soure = ["name":"老王","age":"20","mobile":"1387189393"] as [String : Any]

        //判断是否为json数据
        if JSONSerialization.isValidJSONObject(soure) {
            let json1 = JSON.init(soure)
            print(json1)
            print("name = " + json1["name"].string!)
        }
        
        guard let data =  try? JSONSerialization.data(withJSONObject: soure, options: JSONSerialization.WritingOptions.prettyPrinted) else{ return }
        print("data = \(data)")
        
        let json2 = JSON.init(data: data)
        print("json2 == \(json2)")
        
        /*
         //错误用法,这里stringNoJson非标准json
         let stringNoJson = String.init(format: "%@", soure)
         let json3 = JSON.init(parseJSON: stringNoJson)
         */
        
        let string = String.init(data: data, encoding: .utf8)!
        let json3 = JSON.init(parseJSON: string)
        print("json3 == \(json3)")
        
    }
    
    func handyJSON() {
       let soure = ["name":"老王","age":"20","mobile":"1387189393"] as [String : Any]
    
        if let handyModel = HandyModel.deserialize(from: soure as NSDictionary) {
            print(handyModel.toJSON()!)
            print(handyModel.toJSONString()!)
            print(handyModel.toJSONString(prettyPrint: true)!)
            print(handyModel.toJSONValue()!)
        }
        
        //数组
        let array = [soure,soure]
        let  handyModelArray = [HandyModel].deserialize(from: array as NSArray)
        handyModelArray?.forEach({ (handyModel) in
            print(handyModel ?? "")
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
