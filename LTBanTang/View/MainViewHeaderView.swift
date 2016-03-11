//
//  MainViewHeaderView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/6.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class MainViewHeaderView: UIView {
    
    
    var cycleScrollView:CycleScrollView?
    var bannerBottomView:BannerBottomView?
    var titleBarView:TitleBarView?
    
    var banners:[Banner]? {
        didSet{
            cycleScrollView!.banners = banners
        }
    }
    var bannerBottomElements:[BannerBottomElement]? {
        didSet{
            bannerBottomView!.bannerBottomElements = bannerBottomElements
        }
    }
    
    var categoryElements:[CategoryElement]?{
        didSet{
            titleBarView!.categoryElements = categoryElements!
        }
    }
    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.whiteColor()
        setUpCycleScrollViewWithImageURLs(cycleScrollImageURLStrings)
        setUpButtonSetView(buttonSetImageURLStrings, titles: ["好物","搜索","种草","签到"])
        setUpTitleBarView(titlesOnMainView)
        setUpConstrains()
    }
    //设置循环显示图片
    func setUpCycleScrollViewWithImageURLs(imageURLStrings:[String]) {
        cycleScrollView = CycleScrollView(frame: CGRectMake(0, 0, 320, 160))
        self.addSubview(cycleScrollView!)
    }
    //设置中间button
    func setUpButtonSetView(imageURLStrings:[String], titles:[String]){
        bannerBottomView = BannerBottomView(frame: CGRectMake(0, 200, 300, 100))
        self.addSubview(bannerBottomView!)
    }
    //设置title bar
    func setUpTitleBarView(titles:[String]){
        titleBarView = TitleBarView(frame: CGRectMake(0, 300, 320, 40))
        self.addSubview(titleBarView!)
    }
//添加约束
    func setUpConstrains(){
        for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let views:[String:UIView] = ["cycleScrollView":cycleScrollView!, "mainViewButtonSet":bannerBottomView!,"titleBarView":titleBarView!]
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[cycleScrollView]-0-[mainViewButtonSet]-0-[titleBarView(40)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraint
        
        let cycleScrollViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cycleScrollView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += cycleScrollViewHorizontalConstraint
        
        let cycleScrollViewWHRatioConstraint = NSLayoutConstraint(
            item: cycleScrollView!,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: cycleScrollView!,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.5,
            constant: 0)
        allConstraints.append(cycleScrollViewWHRatioConstraint)
        
        let mainViewButtonSetHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[mainViewButtonSet]-20-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += mainViewButtonSetHorizontalConstraint
        
        let mainViewButtonSetWHRatioConstraint = NSLayoutConstraint(
            item: bannerBottomView!,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: bannerBottomView!,
            attribute: .Width,
            multiplier: 0.3,
            constant: 0)
        allConstraints.append(mainViewButtonSetWHRatioConstraint)
        
        let titleBarViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[titleBarView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleBarViewHorizontalConstraint
        
        self.addConstraints(allConstraints)
        
    }
    
        
}

