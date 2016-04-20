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



struct BanTangRequestKeys {

    static let bantangRecommendBaseURL = "http://open3.bantangapp.com/recommend/index?"
    
    static let clientID = "client_id"
    static let clientSecret = "client_secret"
    static let oauth = "oauth_token"
    static let page = "page"
    static let pageSize = "pagesize"
    static let screenSize = "screensize"
    static let trackUserID = "track_user_id"
    static let v = "v"
}

struct BanTangNewTopicRequestKeys {
    static let bantangTopicDetailBaseURL = "http://open3.bantangapp.com/topic/list?"

    static let clientID = "client_id"
    static let clientSecret = "client_secret"
    static let oauth = "oauth_token"
    static let ids = "ids"
    static let scene = "scene"
    static let page = "page"
    static let pageSize = "pagesize"
    static let screenSize = "screensize"
    static let trackUserID = "track_user_id"
    static let v = "v"
}

struct BanTangRequestValues {
    static let clientID = "bt_app_ios"
    static let clientSecret = "9c1e6634ce1c5098e056628cd66a17a5"
    static let oauth = "2d7546e6cd17c28eefff42eb18348749"
    static let pageSize = "20"
    static let screenSize = "640"
    static let trackUserID = "1948695"
    static let v = "10"
    static let readingIDS = "1273%2C1413%2C1706%2C1146%2C1793%2C1246%2C1564%2C1372%2C1409%2C2001%2C1560%2C1594%2C1959%2C2091%2C1428%2C1736%2C1331%2C1645%2C1478%2C1993%2C1833%2C1743%2C1881%2C1657%2C1335%2C1806%2C1618%2C1622%2C2154%2C1992"
}

struct BanTangResponseKeys {
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
    static let photo = "photoImage"
}

struct BanTangCategoryElementKeys {
    static let ID = "id"
    static let title = "title"
    static let extend = "extend"
}

struct BanTangBannerBottomElementKeys {
    static let ID = "id"
    static let title = "title"
    static let photoURL = "photo"
}

