//
//  ViewController.swift
//  SpeakEnglish
//
//  Created by Jion on 2017/7/4.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lebale: UILabel!
    
    var lable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lebale.text = NSLocalizedString("Title", comment: "标题")
        
        lable.frame = CGRect.init(x: lebale.frame.minX, y: lebale.frame.maxY+20, width: lebale.frame.width, height: lebale.frame.width)
        
        view.addSubview(lable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lable.text = NSLocalizedString("commit", comment: "标签")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

