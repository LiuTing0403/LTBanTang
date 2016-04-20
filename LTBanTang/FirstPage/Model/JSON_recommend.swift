//
//  JSON_recommend.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/10.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import Foundation
import SwiftyJSON

class RecommendResponseObject:NSObject{
    internal let status:Int
    internal let message:String
    internal let ts:Int32
    internal let data:[String:JSON]?
    
    
    init(jsonObject:JSON){
        
        self.status = jsonObject[BanTangResponseKeys.status].intValue
        self.message = jsonObject[BanTangResponseKeys.message].stringValue
        self.ts = jsonObject[BanTangResponseKeys.ts].int32Value
        self.data = jsonObject[BanTangResponseKeys.data].dictionaryValue
        super.init()
    }
}

class RecommendData:NSObject {
    internal var topic:[JSON]?
    internal var banner:[JSON]?
    internal var categoryElement:[JSON]?
    internal var bannerBottomElement:[JSON]?
    
    init(dictionaryObject:[String:JSON]){
        if let u_topic = dictionaryObject[BanTangDataObjectKeys.topic]?.arrayValue {
            self.topic = u_topic
        }
        if let u_banner = dictionaryObject[BanTangDataObjectKeys.banner]?.arrayValue {
            self.banner = u_banner
        }
        if let u_categoryElements = dictionaryObject[BanTangDataObjectKeys.categoryElement]?.arrayValue {
            self.categoryElement = u_categoryElements
        }
        if let u_bannerBottomElement = dictionaryObject[BanTangDataObjectKeys.bannerBottomElement]?.arrayValue {
            self.bannerBottomElement = u_bannerBottomElement
        }
        super.init()
    }
}

class TopicList:NSObject {
    internal let topic:[JSON]
    init(dictionaryObject:[String:JSON]){
        self.topic = (dictionaryObject[BanTangDataObjectKeys.topic]?.arrayValue)!
        super.init()
    }
}

class Topic:NSObject, NSCoding {
    internal let ID:String
    internal let title:String
    internal let likes:Int32
    internal let islike:Bool
    internal let photoURL:NSURL
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangTopicKeys.ID].stringValue
        self.title = jsonObject[BanTangTopicKeys.title].stringValue
        self.likes = jsonObject[BanTangTopicKeys.likes].int32Value
        self.islike = jsonObject[BanTangTopicKeys.isLike].boolValue
        let photoURLString = jsonObject[BanTangTopicKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ID, forKey: BanTangTopicKeys.ID)
        aCoder.encodeObject(title, forKey: BanTangTopicKeys.title)
        aCoder.encodeInt(likes, forKey: BanTangTopicKeys.likes)
        aCoder.encodeBool(islike, forKey: BanTangTopicKeys.isLike)
        aCoder.encodeObject(photoURL, forKey: BanTangTopicKeys.photoURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.ID = aDecoder.decodeObjectForKey(BanTangTopicKeys.ID) as! String
        self.title = aDecoder.decodeObjectForKey(BanTangTopicKeys.title) as! String
        self.likes = aDecoder.decodeInt32ForKey(BanTangTopicKeys.likes)
        self.islike = aDecoder.decodeBoolForKey(BanTangTopicKeys.isLike)
        self.photoURL = aDecoder.decodeObjectForKey(BanTangTopicKeys.photoURL) as! NSURL
        super.init()
    }

}

class Banner:NSObject, NSCoding {
    internal let ID:String
    internal let title:String
    internal let photoURL:NSURL
    //internal let photo:UIImage
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangBannerKeys.ID].stringValue
        self.title = jsonObject[BanTangBannerKeys.title].stringValue
        let photoURLString = jsonObject[BanTangBannerKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
        //self.photo = LibraryAPI().downloadImage(photoURL)
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ID, forKey: BanTangBannerKeys.ID)
        aCoder.encodeObject(title, forKey: BanTangBannerKeys.title)
        aCoder.encodeObject(photoURL, forKey: BanTangBannerKeys.photoURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObjectForKey(BanTangBannerKeys.ID) as! String
        self.title = aDecoder.decodeObjectForKey(BanTangBannerKeys.title) as! String
        self.photoURL = aDecoder.decodeObjectForKey(BanTangBannerKeys.photoURL) as! NSURL
        
        //self.photo = LibraryAPI().downloadImage(photoURL)
        super.init()
    }
    
}

class CategoryElement:NSObject, NSCoding {
    internal let ID:String
    internal let title:String
    internal let extend:String
    
    init(jsonObject:JSON){
        self.ID = jsonObject[BanTangCategoryElementKeys.ID].stringValue
        self.title = jsonObject[BanTangCategoryElementKeys.title].stringValue
        self.extend = jsonObject[BanTangCategoryElementKeys.extend].stringValue
        super.init()
    }
    
    init(ID:String, title:String) {
        self.ID = ID
        self.title = title
        self.extend = ""
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ID, forKey: BanTangCategoryElementKeys.ID)
        aCoder.encodeObject(title, forKey: BanTangCategoryElementKeys.title)
        aCoder.encodeObject(extend, forKey: BanTangCategoryElementKeys.extend)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObjectForKey(BanTangCategoryElementKeys.ID) as! String
        self.title = aDecoder.decodeObjectForKey(BanTangCategoryElementKeys.title) as! String
        self.extend = aDecoder.decodeObjectForKey(BanTangCategoryElementKeys.extend) as! String
        super.init()
    }
    
    
}

class BannerBottomElement:NSObject {
    internal let ID:String
    internal let title:String
    internal let photoURL:NSURL
    
    init(jsonObject:JSON) {

        self.ID = jsonObject[BanTangBannerBottomElementKeys.ID].stringValue
        self.title = jsonObject[BanTangBannerBottomElementKeys.title].stringValue
        let photoURLString = jsonObject[BanTangBannerBottomElementKeys.photoURL].stringValue
        self.photoURL = NSURL(string: photoURLString)!
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ID, forKey: BanTangBannerBottomElementKeys.ID)
        aCoder.encodeObject(title, forKey: BanTangBannerBottomElementKeys.title)
        aCoder.encodeObject(photoURL, forKey: BanTangBannerBottomElementKeys.photoURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObjectForKey(BanTangBannerBottomElementKeys.ID) as! String
        self.title = aDecoder.decodeObjectForKey(BanTangBannerBottomElementKeys.title) as! String
        self.photoURL = aDecoder.decodeObjectForKey(BanTangBannerBottomElementKeys.photoURL) as! NSURL
        super.init()
    }
}