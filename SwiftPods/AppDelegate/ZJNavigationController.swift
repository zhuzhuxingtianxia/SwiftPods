//
//  ZJNavigationController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/4.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class ZJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appperance = UINavigationBarAppearance()
               //添加背景色
            appperance.backgroundColor = .white
            appperance.shadowImage = UIImage()
            appperance.shadowColor = nil

           //设置字体颜色
            appperance.titleTextAttributes = [.foregroundColor: UIColor.black as Any]

            navigationBar.standardAppearance = appperance;
            navigationBar.scrollEdgeAppearance = appperance;

        }
    
        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
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
