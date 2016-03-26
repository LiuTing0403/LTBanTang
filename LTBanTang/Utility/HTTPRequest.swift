//
//  HTTPRequest.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/11.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import Alamofire

private let httpRequest = HTTPRequest()

class HTTPRequest: NSObject {
    class var sharedInstance:HTTPRequest {
        return httpRequest
    }
    
    func getHTTPResponse(urlString:String, parameters:[String:AnyObject]?, completion:(responseObject:Response<AnyObject,NSError>) -> Void) {
        
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { (response) -> Void in
            completion(responseObject: response)
        }
        
    }
    
    func getBanTangRecommendData(page:Int, completion:(responseObject:Response<AnyObject,NSError>) -> Void){
        let parameters:[String:AnyObject] = [
            BanTangRequestKeys.clientID:BanTangRequestValues.clientID,
            BanTangRequestKeys.clientSecret:BanTangRequestValues.clientSecret,
            BanTangRequestKeys.oauth:BanTangRequestValues.oauth,
            BanTangRequestKeys.page:"\(page)",
            BanTangRequestKeys.pageSize:BanTangRequestValues.pageSize,
            BanTangRequestKeys.screenSize:BanTangRequestValues.screenSize,
            BanTangRequestKeys.trackUserID:BanTangRequestValues.trackUserID,
            BanTangRequestKeys.v:BanTangRequestValues.v
        ]
        getHTTPResponse(BanTangRequestKeys.bantangRecommendBaseURL, parameters: parameters) { (responseObject) -> Void in
            completion(responseObject: responseObject)
        }
    }
    
    func getNewTopicData(page:Int, ids:String, scene:String, completion:(responseObject:Response<AnyObject,NSError>) -> Void){
        let parameters:[String:AnyObject] = [
            BanTangNewTopicRequestKeys.clientID:BanTangRequestValues.clientID,
            BanTangNewTopicRequestKeys.clientSecret:BanTangRequestValues.clientSecret,
            BanTangNewTopicRequestKeys.ids:ids,
            BanTangNewTopicRequestKeys.scene:scene,
            BanTangNewTopicRequestKeys.oauth:BanTangRequestValues.oauth,
            BanTangNewTopicRequestKeys.page:"\(page)",
            BanTangNewTopicRequestKeys.pageSize:BanTangRequestValues.pageSize,
            BanTangNewTopicRequestKeys.screenSize:BanTangRequestValues.screenSize,
            BanTangNewTopicRequestKeys.trackUserID:BanTangRequestValues.trackUserID,
            BanTangNewTopicRequestKeys.v:BanTangRequestValues.v
        ]
        getHTTPResponse(BanTangNewTopicRequestKeys.bantangTopicDetailBaseURL, parameters: parameters) { (responseObject) -> Void in
            completion(responseObject: responseObject)
        }
        
        
    }
    
}
