//
//  MainViewController.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/9.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
    
    private var reusableCollectionViewCell = "mainCell"
    
    @IBOutlet weak var headerView: MainViewHeaderView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    private var topics:[Topic]? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    private var banners:[Banner]? {
        didSet{
            self.headerView.banners = banners
        }
    }
    private var categoryElements:[CategoryElement]? {
        didSet{
            self.headerView.categoryElements = categoryElements
        }
    }
    private var bannerBottomElements:[BannerBottomElement]?{
        didSet{
            headerView.bannerBottomElements = bannerBottomElements
        }
    }
    private var requestPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        
        getDataFromWeb()
        
    }
    
    func getDataFromWeb(){
        HTTPRequest().getBanTangRecommendData(requestPage) { (responseObject) -> Void in
            if responseObject.result.error == nil {
                guard let jsonData = responseObject.data
                    else {
                        print("can't get data from response object")
                        return
                }
                let jsonObject = JSON(data: jsonData)
                
                let recommendResponseObject = RecommendResponseObject(jsonObject: jsonObject)
                
              
                let recommendData = RecommendData(dictionaryObject: recommendResponseObject.data!)
                let topicsJSON = recommendData.topic
                let bannersJSON = recommendData.banner
                let categoryElementJSON = recommendData.categoryElement
                let bannerBottomElementJSON = recommendData.bannerBottomElement
                
                self.topics = topicsJSON.map({ (json) -> Topic in
                    return Topic(jsonObject: json)
                })
                
                self.banners = bannersJSON.map({ (json) -> Banner in
                    return Banner(jsonObject: json)
                })
                self.categoryElements = categoryElementJSON.map({ (json) -> CategoryElement in
                    return CategoryElement(jsonObject: json)
                })
                self.categoryElements?.insert(CategoryElement(ID:"0", title:"最新"), atIndex: 0)
                self.bannerBottomElements = bannerBottomElementJSON.map({ (json) -> BannerBottomElement in
                    return BannerBottomElement(jsonObject: json)
                })

            }
        }
    }

}

//MARK: Data Source

extension MainViewController:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCollectionViewCell, forIndexPath: indexPath) as! MainViewCollectionViewCell
        cell.topicList = topics
        return cell
    }
}
//MARK: Flow Layout
extension MainViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
}
//MARK: Delegate
extension MainViewController:UICollectionViewDelegate {
    
}
