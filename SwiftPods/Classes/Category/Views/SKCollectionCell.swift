//
//  SKCollectionCell.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/28.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import Kingfisher

class SKCollectionCell: UICollectionViewCell {
    
    lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.backgroundColor = UIColor.lightGray
        return backImageView
    }()
    
    var imgUrl: String! {
        willSet {
            backImageView.kf.setImage(with: URL.init(string: newValue))
        }
    }
    
// MARK: - 便利构造方法
    override init(frame: CGRect) {
        imgUrl = String.init()
        super.init(frame: frame)
        addSubview(backImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        backImageView.frame = bounds
    }
}
