//
//  Defines.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/6.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import Foundation

let cycleScrollImageURLStrings:[String] =
["http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201602/56574856.jpg?v=1456482280",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201603/97481005.jpg?v=1456803434",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201603/54495510.jpg?v=1457071622",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201603/52559748.jpg?v=1456972164"]

let buttonSetImageURLStrings:[String] =
["http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/10048575.jpg?v=1450328061",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/10054515.jpg?v=1450328077",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/99102509.jpg?v=1450345660",
"http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/98505251.jpg?v=1450328107"]

let titlesOnMainView:[String] = ["最新","文艺","礼物","指南","爱美","设计","吃货","格调","厨房","上班族","学生党","聚会","节日","宿舍"]

struct BanTangRecommendRequestKeys {
    static let baseURL = "http://open3.bantangapp.com/recommend/index?"
    
    static let clientID = "client_id"
    static let clientSecret = "client_secret"
    static let oauth = "oauth_token"

    static let page = "page"
    static let pageSize = "pagesize"
    static let screenSize = "screensize"

    static let trackUserID = "track_user_id"
    static let v = "v"
    
    
}

struct BanTangRecommendRequestValues {
    static let clientID = "bt_app_ios"
    static let clientSecret = "9c1e6634ce1c5098e056628cd66a17a5"
    static let oauth = "2d7546e6cd17c28eefff42eb18348749"
    static let pageSize = "20"
    static let screenSize = "640"
    static let trackUserID = "1948695"
    static let v = "10"
}

struct BanTangRecommendResponseKeys {
    static let status = "status"
    static let message = "mag"
    static let ts = "ts"
    static let data = "data"
}

struct BanTangDataObjectKeys {
    static let topic = "topic"
    static let banner = "banner"
    static let categoryElement = "category_element"
    static let bannerBottomElement = "banner_bottom_element"
}

struct BanTangTopicKeys {
    static let ID = "id"
    static let title = "title"
    static let photoURL = "pic"
    static let likes = "likes"
    static let isLike = "islike"
    
}

struct BanTangBannerKeys {
    static let ID = "id"
    static let title = "title"
    static let photoURL = "photo"
}

struct BanTangCategoryElementKeys {
    static let ID = "id"
    static let title = "title"
}

struct BanTangBannerBottomElementKeys {
    static let ID = "id"
    static let title = "title"
    static let photoURL = "photo"
}

