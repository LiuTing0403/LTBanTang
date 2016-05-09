//
//  LibraryAPI.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/26.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SwiftyJSON


class LibraryAPI: NSObject {
    
    class var sharedInstance:LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    private var httpRequest:HTTPRequest
    private var persistencyManager:PersistencyManager
    
    
    override init() {
        httpRequest = HTTPRequest()
        persistencyManager = PersistencyManager()
        super.init()
    }
    
    func getTopics() -> [[Topic]] {
        return persistencyManager.getTopics()
    }
    
    func getBanners() -> [Banner] {
        return persistencyManager.getBanners()
    }
    
    func getCategoryElements() -> [CategoryElement] {
        return persistencyManager.getCategoryElements()
    }
    
    func getBannerBottomElements() -> [BannerBottomElement] {
        return persistencyManager.getBannerBottomElements()
    }
    
    
    func getNewTopics(index:Int,requestPage:Int, extend:String, completion:()->Void){
        
        var ids = ""
        var scene = ""
        
        if extend.characters.count > 2 {
            ids = extend
        } else {
            scene = extend
        }
        
        HTTPRequest().getNewTopicData(requestPage, ids: ids, scene:scene) { (responseObject) -> Void in
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
                if requestPage == 0 {
                    self.persistencyManager.setMyTopicAtIndex(topic, index:index)
                } else {
                    self.persistencyManager.appendNewTopicAtIndex(topic, index: index)
                }
                completion()
            }
        }
        
    }
    
    func getRecommendData(requestPage:Int, completion:()->Void){
        
        httpRequest.getBanTangRecommendData(requestPage) {
            (responseObject) -> Void in
            if responseObject.result.error == nil {
                guard let jsonData = responseObject.data
                    else {
                        print("can't get data from response object")
                        return
                }
                
                let jsonObject = JSON(data: jsonData)
                
                let recommendResponseObject = RecommendResponseObject(jsonObject: jsonObject)
                let recommendData = RecommendData(dictionaryObject: recommendResponseObject.data!)
                
                var topics = [[Topic]]()
                if let categoryElementJSON = recommendData.categoryElement {
                    var categoryElements = categoryElementJSON.map({ (json) -> CategoryElement in
                        return CategoryElement(jsonObject: json)
                    })
                    categoryElements.insert(CategoryElement(ID:"0", title:"最新"), atIndex: 0)
                    topics = [[Topic]](count: categoryElements.count, repeatedValue: [Topic]())
                    self.persistencyManager.setMyCategoryElements(categoryElements)

                } else {
                    
                }

                if let topicsJSON = recommendData.topic {
                    let topic = topicsJSON.map({ (json) -> Topic in
                        return Topic(jsonObject: json)
                    })
                    
                    if requestPage == 0 {
                        topics[0] = topic
                        self.persistencyManager.setMyTopics(topics)
                    } else {
                        self.persistencyManager.appendNewTopicAtIndex(topic, index: 0)
                    }

                }
                
                if let bannersJSON = recommendData.banner {
                    let banners = bannersJSON.map({ (json) -> Banner in
                        return Banner(jsonObject: json)
                    })
                    self.persistencyManager.setMyBanners(banners)

                }
                
                if let bannerBottomElementJSON = recommendData.bannerBottomElement {
                    let bannerBottomElements = bannerBottomElementJSON.map({ (json) -> BannerBottomElement in
                        return BannerBottomElement(jsonObject: json)
                    })
                    self.persistencyManager.setMyCannerBottomElements(bannerBottomElements)

                }

                completion()
            }
        }
    }
    
    func downloadImage(imageURL: NSURL) -> UIImage {
        return httpRequest.downLoadImage(imageURL)
    }

}
