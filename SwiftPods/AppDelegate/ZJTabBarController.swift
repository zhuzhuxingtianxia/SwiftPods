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
        boaryCreateSubControllers()
        self.delegate = self
    }
    
    func boaryCreateSubControllers() {
        let classNames = ["Home","Category","Find","ShopCart","My"]
        let normalImages = ["tabBar_home_normal","tabBar_category_normal","tabBar_find_normal","tabBar_cart_normal","tabBar_myJD_normal",]
        let selectImages = ["tabBar_home_press","tabBar_category_press","tabBar_find_press","tabBar_cart_press","tabBar_myJD_press",]
        
        for i in 0..<classNames.count {
            
            let stotyboard = UIStoryboard.init(name: classNames[i], bundle: nil)
            let navc = stotyboard.instantiateInitialViewController()
            
            navc?.tabBarItem.image = UIImage.init(named: normalImages[i])?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            navc?.tabBarItem.selectedImage = UIImage.init(named: selectImages[i])?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            navc?.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            
            /*
            navc?.tabBarItem.title = ""
            
            let noral = [NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
            
            navc?.tabBarItem.setTitleTextAttributes(noral, for: UIControlState.normal)
            
            let selectAttri:[String:Any] = [NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
            navc?.tabBarItem.setTitleTextAttributes(selectAttri, for: UIControlState.selected)
            */
            self.addChild(navc!)
            
        }
        
    }

    func createSubControllers() {
        let classNames = ["HomeController","CategoryController","FindController","ShopCartController","MyController"]
        let normalImages = ["tabBar_home_normal","tabBar_category_normal","tabBar_find_normal","tabBar_cart_normal","tabBar_myJD_normal",]
        let selectImages = ["tabBar_home_press","tabBar_category_press","tabBar_find_press","tabBar_cart_press","tabBar_myJD_press",]
        
        for i in 0..<classNames.count {
            
            let vc = ZJClassFromString(className: classNames[i]).init()
            let navc = ZJNavigationController.init(rootViewController: vc as! UIViewController)
            
            navc.tabBarItem.image = UIImage.init(named: normalImages[i])?.withRenderingMode(.alwaysOriginal)
            navc.tabBarItem.selectedImage = UIImage.init(named: selectImages[i])?.withRenderingMode(.alwaysOriginal)
            navc.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            
            /*
             navc?.tabBarItem.title = ""
             
             let noral = [NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
             
             navc?.tabBarItem.setTitleTextAttributes(noral, for: UIControlState.normal)
             
             let selectAttri:[String:Any] = [NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 10)]
             navc?.tabBarItem.setTitleTextAttributes(selectAttri, for: UIControlState.selected)
             */
            self.addChild(navc)
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

private var isLogin = false
extension ZJTabBarController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectIndex = children.index(of: viewController)
        if (selectIndex==3 || selectIndex == 4) && !isLogin {
            let login = UINavigationController.init(rootViewController: LonginController.init())
            present(login, animated: true, completion: { 
                isLogin = true
            })
        }
    }
}
