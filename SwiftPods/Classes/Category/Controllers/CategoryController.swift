//
//  CategoryController.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/4.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit

class CategoryController: BaseViewController {
    
   fileprivate let tableView = UITableView()
    fileprivate var dataArray:[CategoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buildTableView()
        CategoryViewModel.reloadSource { (array) in
            dataArray = array
            tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func buildTableView(){
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        view.addSubview(tableView)
    }


}

extension CategoryController:UITableViewDelegate,UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = CategoryCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell?.selectionStyle = .none
        }
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.title
        return cell!
    }
    
}
