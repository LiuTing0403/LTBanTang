//
//  CycleScrollView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/6.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SDWebImage

protocol CycleScrollViewDelegate {
    func numberOfItemsInCycleScrollView(cycleScrollView:CycleScrollView) -> Int
    func imagesForCycleScrollView(cycleScrollView:CycleScrollView)-> [UIImage]
    func cycleScrollView(cycleScrollView:CycleScrollView, didSelectedItemAtIndex index:Int)
}

class CycleScrollView: UIView {
    
    private let reusableCycleCell = "CycleCell"
    
    private var timer:NSTimer?
    private var pageIndicator = UIPageControl()
    private var collectionView:UICollectionView!
    private var collectionViewFlowLayout:UICollectionViewFlowLayout!
    private var imageGroup = [UIImage]()
    
    private var pageCount:Int = 0 {
        didSet{
            self.pageIndicator.numberOfPages = pageCount
        }
    }
    var scrollInterval:Double = 3.0
    private var counter:Int = 0
    
    var delegate:CycleScrollViewDelegate? {
        didSet{
            self.reloadAllData()
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
        addPageIndicator()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CycleScrollView.reloadBannerData), name: "ReloadDataForBanner", object: nil)
    }
    
    override func awakeFromNib() {
        setUpScrollView()
        addPageIndicator()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CycleScrollView.reloadBannerData), name: "ReloadDataForBanner", object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func reloadAllData(){
        if let delegate = self.delegate {
            pageCount = delegate.numberOfItemsInCycleScrollView(self)
            self.collectionView.reloadData()
            self.imageGroup = delegate.imagesForCycleScrollView(self)
            setUpAutoScrollTimer()
        }
    }
    
//    func reloadBannerData(notification:NSNotification) {
//        print("banner notification")
//        let userInfo  = notification.userInfo as! [String:AnyObject]
//        if let unwrappedBanners = userInfo["banners"] as? [Banner]{
//            if unwrappedBanners.count > 0 {
//        
//                self.collectionView.reloadData()
//                setUpAutoScrollTimer()
//            }
//        }
//    }
    
    //设置scroll view
    internal func setUpScrollView(){
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal

        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reusableCycleCell)
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)

        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        
        
    }
    //添加页面指示
    internal func addPageIndicator(){
        
        
        pageIndicator.numberOfPages = pageCount
        pageIndicator.hidesForSinglePage = true
        pageIndicator.currentPageIndicatorTintColor = UIColor.redColor()
        pageIndicator.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageIndicator.frame.size = pageIndicator.sizeForNumberOfPages(pageCount)
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageIndicator)

        self.addConstraint(NSLayoutConstraint(item: pageIndicator, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pageIndicator, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -8))
    }
    //设置自动翻页
    internal func setUpAutoScrollTimer(){
        timer = NSTimer(timeInterval: scrollInterval, target: self, selector: #selector(CycleScrollView.autoScroll), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)

    }
    
    
    internal func autoScroll(){
        counter += 1
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: counter, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("lay out subviews")
        collectionViewFlowLayout.itemSize = self.frame.size
    }

}
//MARK:Collection View Data Source
extension CycleScrollView:UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let delegate = self.delegate {
            return delegate.numberOfItemsInCycleScrollView(self) * 1000
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCycleCell, forIndexPath: indexPath)
        let imageView = UIImageView(frame: cell.contentView.frame)
        imageView.image = imageGroup[indexPath.row % pageCount]
    

        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
}
//MARK:Scroll View Delegate
extension CycleScrollView:UIScrollViewDelegate {
    //当翻页时修改page indicator
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageIndicator.currentPage = Int(scrollView.contentOffset.x / self.width()) % pageCount
        counter = Int(scrollView.contentOffset.x / self.width())
    }
    //当手动翻页时停止记时
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer?.invalidate()
    }
    //当手动翻页停止时重新开始计时
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        setUpAutoScrollTimer()
    }
    
}
//MARK: Collection View Delegate
extension CycleScrollView:UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didselectItemAtIndexPath indexPath: NSIndexPath) {
        if let delegate = self.delegate {
            delegate.cycleScrollView(self, didSelectedItemAtIndex: indexPath.row % pageCount)
        }
        
        
    }
    
}
