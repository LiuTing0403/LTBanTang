//
//  PersistencyManager.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/26.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
    private var firstPageData:FirstPageData
   
    override init() {
        if let data = NSData(contentsOfFile: NSHomeDirectory().stringByAppendingString("/Documents/firstPageData.bin")){
            let unarchivedFirstPageData = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? FirstPageData
            if let unwrappedFirstPageData = unarchivedFirstPageData {
                self.firstPageData = unwrappedFirstPageData
                print("get data from archive")
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForTopics", object: self.firstPageData.topics, userInfo: ["topics":firstPageData.topics])
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForBanner", object: self.firstPageData.banners, userInfo: ["banners":firstPageData.banners])
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForCategoryElements", object: self.firstPageData.categoryElements, userInfo: ["categoryElements":self.firstPageData.categoryElements])
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForBannerBottomElements", object: self.firstPageData.bannerBottomElements, userInfo: ["bannerBottomElements":self.firstPageData.bannerBottomElements])
            } else {
                print("unarchive failed")
                self.firstPageData = FirstPageData()
            }
        } else {
            print("no archive data ")
            self.firstPageData = FirstPageData()

        }
        
        super.init()
    }
    
    func setMyTopics(topics:[[Topic]]){
        self.firstPageData.topics = topics
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForTopics", object: self.firstPageData.topics, userInfo: ["topics":firstPageData.topics])
        saveFirstPageData()
    }
    
    func resetAllData() {
        firstPageData = FirstPageData()
        saveFirstPageData()
    }
    
    func setMyTopicAtIndex(topic:[Topic], index:Int) {
        self.firstPageData.topics[index] = topic
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForTopics", object: self.firstPageData.topics, userInfo: ["topics":firstPageData.topics])
        saveFirstPageData()
       
    }
    func appendNewTopicAtIndex(topic:[Topic], index:Int) {
        self.firstPageData.topics[index] += topic
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForTopics", object: self.firstPageData.topics, userInfo: ["topics":firstPageData.topics])
    }
    func setMyBanners(banners:[Banner]) {
        self.firstPageData.banners = banners
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForBanner", object: self.firstPageData.banners, userInfo: ["banners":firstPageData.banners])
        saveFirstPageData()
        
    }
    func setMyCategoryElements(categoryElements:[CategoryElement]) {
        self.firstPageData.categoryElements = categoryElements
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForCategoryElements", object: self.firstPageData.categoryElements, userInfo: ["categoryElements":self.firstPageData.categoryElements])
    }
    func setMyCannerBottomElements(bannerBottomElements:[BannerBottomElement]) {
        self.firstPageData.bannerBottomElements = bannerBottomElements
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataForBannerBottomElements", object: self.firstPageData.bannerBottomElements, userInfo: ["bannerBottomElements":self.firstPageData.bannerBottomElements])
    }
    
    func getFirstPageData() -> ([[Topic]], [Banner], [CategoryElement], [BannerBottomElement]) {
        return firstPageData.getFirstPageData()
    }
    
    func getTopics() -> [[Topic]] {
        return self.firstPageData.topics
    }
    
    func getBanners() -> [Banner] {
        return self.firstPageData.banners
    }
    
    func getCategoryElements() -> [CategoryElement] {
        return self.firstPageData.categoryElements
    }
    
    func getBannerBottomElements() -> [BannerBottomElement] {
        return self.firstPageData.bannerBottomElements
    }
    
    func saveFirstPageData() {
        let filename = NSHomeDirectory().stringByAppendingString("/Documents/firstPageData.bin")
        let data = NSKeyedArchiver.archivedDataWithRootObject(firstPageData)
        data.writeToFile(filename, atomically: true)
    }

}
