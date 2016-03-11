//
//  SingleTitleButtonCell.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/7.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class BannerBottomCell: UICollectionViewCell {
    
    internal var imageView:UIImageView?
    internal var textLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(){
        imageView = UIImageView(image: UIImage(named: "goodButton"))
        imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel?.textColor = UIColor.grayColor()
        textLabel?.font = UIFont.systemFontOfSize(15)
        textLabel?.numberOfLines = 1
        textLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        textLabel?.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(textLabel!)
        self.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]

    }
    
    func setUpConstraints(){
        for view in self.contentView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let views:[String:UIView] = ["imageView":imageView!,"textLabel":textLabel!]
        var allConstraints = [NSLayoutConstraint]()
        
        let imageViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[imageView]-20-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += imageViewHorizontalConstraint
        
        let imageViewWHRatioConstraint = NSLayoutConstraint(
            item: imageView!,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: imageView,
            attribute: .Width,
            multiplier: 1,
            constant: 0)
        allConstraints.append(imageViewWHRatioConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[imageView]-10-[textLabel]",
            options: [NSLayoutFormatOptions.AlignAllCenterX],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraint
        
        let textLabelHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[textLabel]-20-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += textLabelHorizontalConstraint
        
        self.contentView.addConstraints(allConstraints)
        
    }
    
    
    
}
