//
//  JSON_recommend.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/10.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RecommendResponseObject {
    internal let status:Int
    internal let message:String
    internal let ts:Int32
    internal let data:[String:JSON]?
    
    
    init(jsonObject:JSON){
        self.status = jsonObject[BanTangRecommendResponseKeys.status].intValue
        self.message = jsonObject[BanTangRecommendResponseKeys.message].stringValue
        self.ts = jsonObject[BanTangRecommendResponseKeys.ts].int32Value
        self.data = jsonObject[BanTangRecommendResponseKeys.data].dictionaryValue
    }
}

struct RecommendData {
    internal let topic:[JSON]
    internal let banner:[JSON]
    internal let categoryElement:[JSON]
    internal let bannerBottomElement:[JSON]
    
    init(dictionaryObject:[String:JSON]){
        self.topic = (dictionaryObject[BanTangDataObjectKeys.topic]?.arrayValue)!
        self.banner = (dictionaryObject[BanTangDataObjectKeys.banner]?.arrayValue)!
        self.categoryElement = (dictionaryObject[BanTangDataObjectKeys.categoryElement]?.arrayValue)!
        self.bannerBottomElement = (dictionaryObject[BanTangDataObjectKeys.bannerBottomElement]?.arrayValue)!
    }
}

struct Topic {
    internal let ID:String
    internal let title:String
    internal let likes:Int
    internal let islike:Bool
    internal let photoURL:NSURL
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangTopicKeys.ID].stringValue
        self.title = jsonObject[BanTangTopicKeys.title].stringValue
        self.likes = jsonObject[BanTangTopicKeys.likes].intValue
        self.islike = jsonObject[BanTangTopicKeys.isLike].boolValue
        let photoURLString = jsonObject[BanTangTopicKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
    }
}

struct Banner {
    internal let ID:String
    internal let title:String
    internal let photoURL:NSURL
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangBannerKeys.ID].stringValue
        self.title = jsonObject[BanTangBannerKeys.title].stringValue
        let photoURLString = jsonObject[BanTangBannerKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
    }
    
}

struct CategoryElement {
    internal let ID:String
    internal let title:String
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangCategoryElementKeys.ID].stringValue
        self.title = jsonObject[BanTangCategoryElementKeys.title].stringValue
    }
    
    init(ID:String, title:String) {
        self.ID = ID
        self.title = title
    }
    
}

struct BannerBottomElement {
    internal let ID:String
    internal let title:String
    internal let photoURL:NSURL
    
    init(jsonObject:JSON) {

        self.ID = jsonObject[BanTangBannerBottomElementKeys.ID].stringValue
        self.title = jsonObject[BanTangBannerBottomElementKeys.title].stringValue
        let photoURLString = jsonObject[BanTangBannerBottomElementKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
    }
    
}