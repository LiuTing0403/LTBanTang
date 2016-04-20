//
//  FirstPageData.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/26.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class FirstPageData: NSObject, NSCoding {
    
    var topics = [[Topic]]()
    var banners = [Banner]()
    var categoryElements = [CategoryElement]()
    var bannerBottomElements = [BannerBottomElement]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.topics = aDecoder.decodeObjectForKey("topics") as! [[Topic]]
        self.banners = aDecoder.decodeObjectForKey("banners") as! [Banner]
        self.categoryElements = aDecoder.decodeObjectForKey("categoryElements") as! [CategoryElement]
        self.bannerBottomElements = aDecoder.decodeObjectForKey("bannerBottomElements") as! [BannerBottomElement]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(topics, forKey: "topics")
        aCoder.encodeObject(banners, forKey: "banners")
        aCoder.encodeObject(categoryElements, forKey: "categoryElements")
        aCoder.encodeObject(bannerBottomElements, forKey: "bannerBottomElements")
    }
    
    func getFirstPageData() -> ([[Topic]], [Banner], [CategoryElement], [BannerBottomElement]) {
        return (topics, banners, categoryElements, bannerBottomElements)
    }

}
