//
//  PersistencyManager.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/26.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
    private var topics:[[Topic]] = []
    private var banners:[Banner] = []
    private var categoryElements:[CategoryElement] = []
    private var bannerBottomElements:[BannerBottomElement] = []
    
    override init() {
        super.init()
    }
    
    func setTopics(topics:[[Topic]]){
        self.topics = topics
    }
    
    func setBanners(banners:[Banner]) {
        self.banners = banners
    }
    func categoryElements(categoryElements:[CategoryElement]) {
        self.categoryElements = categoryElements
    }
    func bannerBottomElements(bannerBottomElements:[BannerBottomElement]) {
        self.bannerBottomElements = bannerBottomElements
    }
    
    
    
    
    

}
