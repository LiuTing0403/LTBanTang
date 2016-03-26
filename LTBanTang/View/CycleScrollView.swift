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
    func cycleScrollView(collectionView:UICollectionView, didSelectedItemAtIndex index:Int)
}

class CycleScrollView: UIView {
    
    private let reusableCycleCell = "CycleCell"
    
    private var imageGroup:[UIImage]?
    internal var banners:[Banner]? {
        didSet{
            self.pageCount          = banners!.count
            self.imageGroup         = self.banners?.map({ (banner) -> UIImage in
                guard let data = NSData(contentsOfURL: banner.photoURL)
                    else {
                        print("URL is invalid")
                        return UIImage(named: "scrollImage_1")!
                }
                guard let image = UIImage(data: data)
                    else {
                        print("error in get Image from nsdata")
                        return UIImage(named: "scrollImage_1")!
                }
                return image
            })
            
            self.collectionView?.reloadData()
            setUpAutoScrollTimer()

            
        }
    }
    
    private var pageIndicator:UIPageControl?
    private var bezierPath:UIBezierPath?
    private var timer:NSTimer?
    private var collectionView:UICollectionView?
    private var collectionViewFlowLayout:UICollectionViewFlowLayout?
    
    private var pageCount:Int = 1 {
        didSet{
            self.pageIndicator?.numberOfPages = pageCount
        }
    }
    private var scrollInterval:Double = 3.0
    private var counter:Int = 0
    
    internal var delegate:CycleScrollViewDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpScrollView()
        addPageIndicator()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    convenience init(frame:CGRect, imageGroup:[UIImage]) {
//        self.init(frame:frame)
//        self.imageGroup = imageGroup
//        self.pageCount  = imageGroup.count
//        setUpScrollView()
//        addPageIndicator()
//        setUpAutoScrollTimer()
//        
//    }
    
//    convenience init(frame:CGRect, banners:[Banner]) {
//        self.init(frame:frame)
//        self.banners = banners
//        self.pageCount          = banners.count
//        self.imageGroup         = banners.map({(banner) -> UIImage in
//            
//            guard let data = NSData(contentsOfURL: banner.photoURL)
//                else {
//                    print("URL is invalid")
//                    return UIImage(named: "scrollImage_1")!
//            }
//            guard let image = UIImage(data: data)
//                else {
//                    print("error in get Image from nsdata")
//                    return UIImage(named: "scrollImage_1")!
//                }
//            return image
//        })
//        
//        setUpScrollView()
//        addPageIndicator()
//        setUpAutoScrollTimer()
//        
//    }
    //设置scroll view
    internal func setUpScrollView(){
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout!.minimumInteritemSpacing = 0
        collectionViewFlowLayout!.minimumLineSpacing = 0
        collectionViewFlowLayout!.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout!)
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reusableCycleCell)
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.dataSource = self
        collectionView?.delegate = self

        self.addSubview(collectionView!)
        
    }
    //添加页面指示
    internal func addPageIndicator(){
        
        pageIndicator = UIPageControl()
        
        pageIndicator?.numberOfPages = pageCount
        pageIndicator?.hidesForSinglePage = true
        pageIndicator?.currentPageIndicatorTintColor = UIColor.redColor()
        pageIndicator?.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageIndicator?.frame.size = (pageIndicator?.sizeForNumberOfPages(pageCount))!
        pageIndicator?.center = CGPointMake(self.centerX(),self.maxY()-8)
        self.addSubview(pageIndicator!)
    }
    //设置自动翻页
    internal func setUpAutoScrollTimer(){
        timer = NSTimer(timeInterval: scrollInterval, target: self, selector: #selector(CycleScrollView.autoScroll), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)

    }
    
    
    internal func autoScroll(){
        
        counter += 1
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: counter, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
        
    }
    //添加蒙版图层
    internal func addMaskLayer(){
        
        bezierPath = UIBezierPath(ovalInRect: CGRectMake(0, self.maxY() - 30, self.width(), 60))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath!.CGPath
        maskLayer.fillColor = UIColor.whiteColor().CGColor
        
        self.layer.addSublayer(maskLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        print("lay out subviews")
        collectionViewFlowLayout?.itemSize = self.frame.size
        collectionView?.frame = self.frame
        pageIndicator?.center = CGPointMake(self.centerX(),self.maxY()-8)

    }

}
//MARK:Collection View Data Source
extension CycleScrollView:UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if banners == nil {
            return 0
        } else {
            return pageCount * 1000
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCycleCell, forIndexPath: indexPath)
        let imageView = UIImageView(frame: cell.contentView.frame)
        imageView.image = imageGroup![indexPath.row % pageCount]
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
}
//MARK:Scroll View Delegate
extension CycleScrollView:UIScrollViewDelegate {
    //当翻页时修改page indicator
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageIndicator?.currentPage = Int(scrollView.contentOffset.x / self.width()) % pageCount
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
        let currentPage = pageIndicator?.currentPage
        delegate?.cycleScrollView(collectionView, didSelectedItemAtIndex: currentPage!)
        print("did selected cycle scroll view at index \(pageIndicator?.currentPage)")
    }
    
}
