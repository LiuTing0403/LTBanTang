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
            BanTangRecommendRequestKeys.clientID:BanTangRecommendRequestValues.clientID,
            BanTangRecommendRequestKeys.clientSecret:BanTangRecommendRequestValues.clientSecret,
            BanTangRecommendRequestKeys.oauth:BanTangRecommendRequestValues.oauth,
            BanTangRecommendRequestKeys.page:"\(page)",
            BanTangRecommendRequestKeys.pageSize:BanTangRecommendRequestValues.pageSize,
            BanTangRecommendRequestKeys.screenSize:BanTangRecommendRequestValues.screenSize,
            BanTangRecommendRequestKeys.trackUserID:BanTangRecommendRequestValues.trackUserID,
            BanTangRecommendRequestKeys.v:BanTangRecommendRequestValues.v
        ]
        getHTTPResponse(BanTangRecommendRequestKeys.baseURL, parameters: parameters) { (responseObject) -> Void in
            completion(responseObject: responseObject)
        }
    }
    
}
