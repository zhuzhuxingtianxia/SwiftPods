//
//  ChartsController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//  事例地址：https://www.hangge.com/blog/cache/detail_2118.html
//  非连续曲线处理：https://www.it72.com/12369.htm

import UIKit

class ChartsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "图表库"
        
        let demo = DemoListViewController()
        demo.view.frame = view.bounds
        addChild(demo)
        view.addSubview(demo.view)
        
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
