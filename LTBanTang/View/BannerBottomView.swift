//
//  SingleTitleButtonSetView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/7.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class BannerBottomView: UIView {
    
    private let reusableCell = "reusableCell"
    
    private var collectionView:UICollectionView?
    private var collectionViewFlowLayout:UICollectionViewFlowLayout?

    private var imageGroup:[UIImage]?
    private var imageURLStrings:[String]?
    private var bannerBottomElements:[BannerBottomElement] = []
    
    private var titles:[String]?
    private var elementCount:Int = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
        setUpConstraints()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BannerBottomView.reloadBannerBottomData), name: "ReloadDataForBannerBottomElements", object: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func reloadBannerBottomData(notification:NSNotification) {
        let userInfo  = notification.userInfo as! [String:AnyObject]

        bannerBottomElements = userInfo["bannerBottomElements"] as! [BannerBottomElement]
        elementCount = bannerBottomElements.count
        collectionView?.reloadData()
    }
    
    //设置collection view
    func setUpCollectionView(){
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout?.minimumInteritemSpacing = 0
        collectionViewFlowLayout?.minimumLineSpacing = 0
        
    
        collectionView = UICollectionView(frame: CGRectMake(0, 0, 300, 100), collectionViewLayout: collectionViewFlowLayout!)
        collectionView?.registerClass(BannerBottomCell.self, forCellWithReuseIdentifier: reusableCell)
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.addSubview(collectionView!)
    }
    //添加约束
    func setUpConstraints(){
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String:UIView] = ["collectionView":collectionView!]
        var allConstraints = [NSLayoutConstraint]()
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collectionView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraint
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collectionView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraint
        self.addConstraints(allConstraints)
    }
    
}
//MARK: Data Source
extension BannerBottomView:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerBottomElements.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCell, forIndexPath: indexPath) as! BannerBottomCell
        let element = bannerBottomElements[indexPath.row]
        cell.textLabel?.text = element.title
        cell.imageView?.sd_setImageWithURL(element.photoURL)
        
        return cell
    }

}
extension BannerBottomView:UICollectionViewDelegate {
    
}
extension BannerBottomView:UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size =  CGSizeMake(self.width()/CGFloat(elementCount), self.height())
        return size

    }
}

