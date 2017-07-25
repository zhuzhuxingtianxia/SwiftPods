//
//  LonginController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/13.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class LonginController: BaseViewController {

    private lazy var login: UIButton = {
        let login = UIButton.init(type: UIButtonType.system)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("登录", for: UIControlState.normal)
        login.setTitleColor(UIColor.white, for: .normal)
        login.backgroundColor = UIColor.blue
        login.addTarget(self, action: #selector(LonginController.loginAction(sender:)), for: UIControlEvents.touchUpInside)
        return login
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        self.title = "登录"
        
        view.addSubview(login)
    }

    func loginAction(sender:UIButton) {
        dismiss(animated: true) { 
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[login]-10-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: [:], views: ["login":login]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[login(40)]-bottom-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["bottom":150], views: ["login":login]))
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
