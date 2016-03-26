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
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    
    @IBOutlet weak var launchImageView: UIImageView!

    private var topics = [[Topic]](count: 16, repeatedValue: [Topic]()){
    //private var topics:[[Topic]] = [[Topic]]()
    
        didSet{
            self.collectionView.reloadData()
            print("reload data")
        }
    }
    private var banners = [Banner]() {
        didSet{
            self.headerView.banners = banners
        }
    }
    private var categoryElements = [CategoryElement]() {
        didSet{
            self.headerView.categoryElements = categoryElements
        }
    }
    private var bannerBottomElements = [BannerBottomElement](){
        didSet{
            headerView.bannerBottomElements = bannerBottomElements
        }
    }
    private var requestPage = 0
    private var ids = ""
    private var scene = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadingView.hidesWhenStopped = true
        self.headerView.titleBarView!.delegate = self
        
        getDataFromWeb()
    }
    
    
    
    func getNewTopics(elementsNumber:Int){
        loadingView.startAnimating()
        if categoryElements[elementsNumber].extend.characters.count > 2 {
            ids = categoryElements[elementsNumber].extend
            scene = ""
        } else {
            scene = categoryElements[elementsNumber].extend
            ids = ""
        }
        
        HTTPRequest().getNewTopicData(0, ids: self.ids, scene:self.scene) { (responseObject) -> Void in
            if responseObject.result.error == nil {
                guard let jsonData = responseObject.data
                    else {
                        print("can't get data from response object")
                        return
                }
                let jsonObject = JSON(data: jsonData)
                let recommendResponseObject = RecommendResponseObject(jsonObject: jsonObject)
                let topicData = recommendResponseObject.data
                let topicListJSON = TopicList(dictionaryObject:topicData!)
                let topicJSON = topicListJSON.topic
                let topic = topicJSON.map({ (json) -> Topic in
                    return Topic(jsonObject: json)
                })
                self.topics[elementsNumber] = topic
                self.loadingView.stopAnimating()
            }
        }
        
    }
    
    func getDataFromWeb(){
        
        HTTPRequest().getBanTangRecommendData(requestPage) {
            (responseObject) -> Void in
            if responseObject.result.error == nil {
                guard let jsonData = responseObject.data
                    else {
                        print("can't get data from response object")
                        return
                }
                print(responseObject.request)
                let jsonObject = JSON(data: jsonData)

                let recommendResponseObject = RecommendResponseObject(jsonObject: jsonObject)
                let recommendData = RecommendData(dictionaryObject: recommendResponseObject.data!)
                let topicsJSON = recommendData.topic
                let bannersJSON = recommendData.banner
                let categoryElementJSON = recommendData.categoryElement
                let bannerBottomElementJSON = recommendData.bannerBottomElement
                
                self.categoryElements = categoryElementJSON.map({ (json) -> CategoryElement in
                    return CategoryElement(jsonObject: json)
                })
                self.categoryElements.insert(CategoryElement(ID:"0", title:"最新"), atIndex: 0)

                let topic = topicsJSON.map({ (json) -> Topic in
                    return Topic(jsonObject: json)
                })
                self.topics = [[Topic]](count: self.categoryElements.count, repeatedValue: [Topic]())
                self.topics[0] = topic
                
                self.banners = bannersJSON.map({ (json) -> Banner in
                    return Banner(jsonObject: json)
                })
                
                                self.bannerBottomElements = bannerBottomElementJSON.map({ (json) -> BannerBottomElement in
                    return BannerBottomElement(jsonObject: json)
                })
                
                self.launchImageView.removeFromSuperview()

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
        return topics.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCollectionViewCell, forIndexPath: indexPath) as! MainViewCollectionViewCell
        cell.topicList = topics[indexPath.row]
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
//MARK: Collection View Delegate
extension MainViewController:UICollectionViewDelegate {

}

//MARK: Scroll View Delegate
extension MainViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let itemIndexPath = NSIndexPath(forItem: Int(scrollView.contentOffset.x / self.view.width()), inSection: 0)
        headerView.titleBarView?.selectItemAtIndexPath(itemIndexPath.row)
        if topics[itemIndexPath.row].count == 0 {
            getNewTopics(itemIndexPath.row)
        }
        
    }
}

extension MainViewController:TitleBarViewDelegate{
    func didSelectedTitleAtIndex(indexPath: NSIndexPath) {
        getNewTopics(indexPath.row)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        
    }
    
}
