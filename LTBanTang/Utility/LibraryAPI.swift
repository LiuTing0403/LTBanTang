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
    
    private var httpRequest:HTTPRequest
    private var persistencyManager:PersistencyManager
    
    
    override init() {
        httpRequest = HTTPRequest()
        persistencyManager = PersistencyManager()
        super.init()
    }
    
//    func getNewTopics(elementsNumber:Int){
//        
//        if categoryElements[elementsNumber].extend.characters.count > 2 {
//            ids = categoryElements[elementsNumber].extend
//            scene = ""
//        } else {
//            scene = categoryElements[elementsNumber].extend
//            ids = ""
//        }
//        
//        HTTPRequest().getNewTopicData(0, ids: self.ids, scene:self.scene) { (responseObject) -> Void in
//            if responseObject.result.error == nil {
//                guard let jsonData = responseObject.data
//                    else {
//                        print("can't get data from response object")
//                        return
//                }
//                let jsonObject = JSON(data: jsonData)
//                let recommendResponseObject = RecommendResponseObject(jsonObject: jsonObject)
//                let topicData = recommendResponseObject.data
//                let topicListJSON = TopicList(dictionaryObject:topicData!)
//                let topicJSON = topicListJSON.topic
//                let topic = topicJSON.map({ (json) -> Topic in
//                    return Topic(jsonObject: json)
//                })
//                self.topics[elementsNumber] = topic
//                self.loadingView.stopAnimating()
//            }
//        }
//        
//    }
    
    func getRecommendData(requestPage:Int){
        
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
                let topicsJSON = recommendData.topic
                let bannersJSON = recommendData.banner
                let categoryElementJSON = recommendData.categoryElement
                let bannerBottomElementJSON = recommendData.bannerBottomElement
                
                var categoryElements = categoryElementJSON.map({ (json) -> CategoryElement in
                    return CategoryElement(jsonObject: json)
                })
                categoryElements.insert(CategoryElement(ID:"0", title:"最新"), atIndex: 0)
                
                let topic = topicsJSON.map({ (json) -> Topic in
                    return Topic(jsonObject: json)
                })
                
                var topics = [[Topic]](count: categoryElements.count, repeatedValue: [Topic]())
                topics[0] = topic
                
                let banners = bannersJSON.map({ (json) -> Banner in
                    return Banner(jsonObject: json)
                })
                
                let bannerBottomElements = bannerBottomElementJSON.map({ (json) -> BannerBottomElement in
                    return BannerBottomElement(jsonObject: json)
                })
                
            }
        }
    }

}
