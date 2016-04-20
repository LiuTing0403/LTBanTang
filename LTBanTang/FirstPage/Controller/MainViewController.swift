//
//  MainViewController.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/9.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class MainViewController: UIViewController {
    
    var reusableCollectionViewCell = "mainCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    
    @IBOutlet weak var cycleScrollView: CycleScrollView!
    
    @IBOutlet weak var titleBarView: TitleBarView!
    
    @IBOutlet weak var navigationBarView: UIView!
    
    
    

    var topics:[[Topic]] = []
    var banners:[Banner] = []
    var categoryElements:[CategoryElement] = []
    var currentCategoryIndex = 0
    var requestPage = 0
    var ids = ""
    var scene = ""
    var dragging = false
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpSubViews()
        
        self.topics = LibraryAPI.sharedInstance.getTopics()
        
        self.categoryElements = LibraryAPI.sharedInstance.getCategoryElements()
        self.addNotifications()
        self.getRecommendData(0){}
    }
    
    func setUpSubViews() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.backgroundScrollView.delegate = self
        self.cycleScrollView.delegate = self
        self.titleBarView.delegate = self
        self.loadingView.hidesWhenStopped = true
        self.backgroundScrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.backgroundScrollView.mj_header.beginRefreshing()
            self.getRecommendData(0){
                self.collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: 0, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: false)
                self.backgroundScrollView.mj_header.endRefreshing()
                print("header refresh")
            }
        })
    }
    
    func addNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.reloadTopics(_:)), name: "ReloadDataForTopics", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.reloadCategoryElements(_:)), name: "ReloadDataForCategoryElements", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.getNewTopicPageAtIndex), name: "RefreshDataForTopicAtIndex", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.reloadBannerData), name: "ReloadDataForBanner", object: nil)
    }

    
    func getNewTopicPageAtIndex() {
        requestPage += 1

        if currentCategoryIndex > 0 {
            getNewTopicAtIndex(currentCategoryIndex, requestPage:requestPage, extend: categoryElements[currentCategoryIndex].extend)
            print("get new topic at request page \(currentCategoryIndex)")

        } else {
            getRecommendData(requestPage){
            }
            print("get recommend data\(requestPage)")

        }
    }
    
    func reloadTopics(notification:NSNotification) {
        print("reload topics")
        let userInfo  = notification.userInfo as! [String:AnyObject]
        self.topics = userInfo["topics"] as! [[Topic]]
        self.collectionView.reloadData()
        
    }
    
    func reloadBannerData(notification:NSNotification) {
        print("banner notification")
        let userInfo  = notification.userInfo as! [String:AnyObject]
        if let unwrappedBanners = userInfo["banners"] as? [Banner]{
            banners = unwrappedBanners
            if unwrappedBanners.count > 0 {
                self.cycleScrollView.reloadAllData()
                
            }
        }
    }
    
    func reloadCategoryElements(notification:NSNotification) {
        let userInfo  = notification.userInfo as! [String:AnyObject]
        self.categoryElements = userInfo["categoryElements"] as! [CategoryElement]
        self.titleBarView.reloadAllData()
    }
    
    func getRecommendData(requestPage:Int, completion:()->Void) {
        LibraryAPI.sharedInstance.getRecommendData(requestPage) {
            completion()
        }
    }
    
    func getNewTopicAtIndex(index:Int, requestPage:Int, extend:String) {
        LibraryAPI.sharedInstance.getNewTopics(index, requestPage:requestPage,extend: extend){
            
        }
    }

}



