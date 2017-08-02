//
//  SKPhotoBrowserVC.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import SwiftPullToRefresh
import PKHUD

class SKPhotoBrowserVC: UIViewController {

    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width:0, height:10)
        layout.itemSize = CGSize.init(width: (ZJScreenWidth - 10) / 2 - 8, height: (ZJScreenWidth - 10) / 2 - 8)
       // layout.scrollDirection = .horizontal
        
       let collection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: ZJScreenWidth, height: ZJScreenHeight - 64), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(SKCollectionCell.self, forCellWithReuseIdentifier: "SKCell")
        
        return collection
    }()
    
    var dataArray: Array<SKPhotoBrowserModel>?
    var images: Array<SKPhoto>?
    
//MARK: -- cycle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        buildCollection()
        fetchData()
    }

    func buildCollection() {
        // Static setup
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayStatusbar = true
        
        //背景是否变暗
        HUD.dimsBackground = false
        //HUD显示时是否可以响应事件
        HUD.allowsInteraction = true
        
        collectionView.spr_setTextHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                
                self.fetchData()
            })
        }
        view.addSubview(collectionView)
    }
    
    func fetchData() {
        HUD.show(.rotatingImage(PKHUDAssets.progressCircularImage))
        //HUD.flash(.rotatingImage(PKHUDAssets.progressCircularImage), delay: 2.0)
        SKPhotoBrowserModel.alamofireFetch(url: imgSetUrl) {[weak self] (jsonData) in
    
            self?.collectionView.spr_endRefreshing()
            
            if Int(jsonData["status"] as! String) == 200 {
                HUD.hide(animated: true)
                
                let result = jsonData["data"]
                self?.dataArray = SKPhotoBrowserModel.dcObjectArrayWithKeyValuesArray(result as! NSArray) as? Array<SKPhotoBrowserModel>
                
                self?.images = self?.dataArray?.map{ value in
                    
                    let photo = SKPhoto.photoWithImageURL(value.img_url!)
                    photo.caption = value.img_title
                    // you can use image cache by true(NSCache)
                    photo.shouldCachePhotoURLImage = false
                    
                    return photo
                }
                
                self?.collectionView.reloadData()
                
            }else{
                HUD.flash(.error, delay: 1.0)
                print(jsonData["message"]!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UICollectionViewDelegate

extension SKPhotoBrowserVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataArry = dataArray else {
            return 0
        }
        return dataArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SKCell", for: indexPath) as? SKCollectionCell else {
            return UICollectionViewCell()
        }
       
        cell.imgUrl = dataArray?[indexPath.item].img_url
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? SKCollectionCell else {
            return
        }
        
        // some image for baseImage
        let originImage = cell.backImageView.image
        let browser = SKPhotoBrowser(originImage: originImage ?? UIImage() , photos: images!, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
        //browser.updateCloseButton(UIImage(named: "image1.jpg")!)
        present(browser, animated: true, completion: {})
   
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (ZJScreenWidth - 10) / 2 - 8, height: 300)
        } else {
            return CGSize(width: (ZJScreenWidth - 10) / 2 - 8, height: (ZJScreenWidth - 10) / 2 - 8)
        }
    }

    
}

// MARK: - SKPhotoBrowserDelegate

extension SKPhotoBrowserVC: SKPhotoBrowserDelegate {
    func didShowPhotoAtIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willDismissAtPageIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willShowActionSheet(_ photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(_ index: Int) {
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        //做移除操作
        //SKCache.sharedCache.removeImageForKey("somekey")
        reload()
    }
    
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }

}
