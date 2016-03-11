//
//  TopicTableViewCell.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/10.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    internal var topicImageView:UIImageView?
    internal var topicTitleLabel:UILabel?
    internal var topicLikeLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubviews()
        setUpConstraints()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //设置subview
    func setUpSubviews(){
        
        self.contentView.autoresizingMask = [
            UIViewAutoresizing.FlexibleHeight,
            UIViewAutoresizing.FlexibleWidth]
        
        topicImageView = UIImageView()
        topicImageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(topicImageView!)
        
        topicTitleLabel = UILabel()
        topicTitleLabel?.textAlignment = NSTextAlignment.Center
        topicTitleLabel?.font = UIFont.systemFontOfSize(17)
        topicTitleLabel?.textColor = UIColor.grayColor()
        self.contentView.addSubview(topicTitleLabel!)
        
        topicLikeLabel = UILabel()
        topicLikeLabel?.textAlignment = NSTextAlignment.Center
        topicLikeLabel?.font = UIFont.systemFontOfSize(15)
        topicLikeLabel?.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(topicLikeLabel!)
        
    }
    //添加约束
    func setUpConstraints(){
        
        for view in self.contentView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let views:[String:UIView] = [
            "topicImageView":topicImageView!,
            "topicLikeLabel":topicLikeLabel!,
            "topicTitleLabel":topicTitleLabel!]
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[topicImageView]-5-[topicTitleLabel]-5-[topicLikeLabel]-5-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += verticalConstraint
        
        let imageHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[topicImageView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += imageHorizontalConstraint
        
        let titleHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[topicTitleLabel]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleHorizontalConstraint
        
        let likesHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[topicLikeLabel]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += likesHorizontalConstraint
        
        let imageHWRatioConstraint = NSLayoutConstraint(
            item: topicImageView!,
            attribute: NSLayoutAttribute.Height,
            relatedBy: .Equal,
            toItem: topicImageView!,
            attribute: .Width,
            multiplier: 33/62,
            constant: 0)
        allConstraints.append(imageHWRatioConstraint)
        
        self.contentView.addConstraints(allConstraints)
    }
}
