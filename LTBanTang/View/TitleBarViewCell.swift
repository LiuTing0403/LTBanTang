//
//  TitleBarViewCell.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/8.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class TitleBarViewCell: UICollectionViewCell {
    
    internal var textLabel:UILabel?
    override var selected:Bool {
        didSet {
            if selected {
                textLabel?.textColor = UIColor.redColor()
            } else {
                textLabel?.textColor = UIColor.grayColor()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(){
        textLabel = UILabel()
        textLabel?.font = UIFont.systemFontOfSize(14)
        textLabel?.numberOfLines = 1
        textLabel?.textAlignment = NSTextAlignment.Center
        textLabel?.textColor = UIColor.grayColor()
        self.contentView.addSubview(textLabel!)
        
        self.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpConstraints(){
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
 
        
        var allConstraints = [NSLayoutConstraint]()
        
        let textLabelCenterX = NSLayoutConstraint(
            item: textLabel!,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0)
        allConstraints.append(textLabelCenterX)
        
        let textLabelCenterY = NSLayoutConstraint(
            item: textLabel!,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        allConstraints.append(textLabelCenterY)
        
        self.contentView.addConstraints(allConstraints)
        
    }
    

    
    
    
    
    
}
