//
//  ZJTabBarController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/4.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class ZJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.barTintColor = UIColor.white
        createSubControllers()
    }
    
    func createSubControllers() {
        let classNames = ["Home","Category","Find","ShopCart","My"]
        let normalImages = ["tabBar_home_normal","tabBar_category_normal","tabBar_find_normal","tabBar_cart_normal","tabBar_myJD_normal",]
        let selectImages = ["tabBar_home_press","tabBar_category_press","tabBar_find_press","tabBar_cart_press","tabBar_myJD_press",]
        
        for i in 0..<classNames.count {
            
            let stotyboard = UIStoryboard.init(name: classNames[i], bundle: nil)
            let navc = stotyboard.instantiateInitialViewController()
            
            navc?.tabBarItem.image = UIImage.init(named: normalImages[i])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            navc?.tabBarItem.selectedImage = UIImage.init(named: selectImages[i])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            navc?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
            
            /*
            navc?.tabBarItem.title = ""
            
            let noral = [NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
            
            navc?.tabBarItem.setTitleTextAttributes(noral, for: UIControlState.normal)
            
            let selectAttri:[String:Any] = [NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
            navc?.tabBarItem.setTitleTextAttributes(selectAttri, for: UIControlState.selected)
            */
            self.addChildViewController(navc!)
            
        }
        
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
