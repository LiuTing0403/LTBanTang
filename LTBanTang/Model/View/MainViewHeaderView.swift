//
//  MainViewHeaderView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/6.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SDCycleScrollView


class MainViewHeaderView: UICollectionReusableView {
    
    
    var cycleScrollView:CycleScrollView?
    
    override func awakeFromNib() {
        
        setUpCycleScrollViewWithImageURLs(cycleScrollImageURLStrings)
    }
    
    
    func setUpCycleScrollViewWithImageURLs(imageURLStrings:[String]) {
        
        cycleScrollView = CycleScrollView(frame: CGRectMake(0, 0, self.width(), self.width()/2), imageURLStrings: imageURLStrings)
        
        self.addSubview(cycleScrollView!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cycleScrollView?.frame = CGRectMake(0, 0, self.width(), self.width()/2)
        
    }

    
        
}
