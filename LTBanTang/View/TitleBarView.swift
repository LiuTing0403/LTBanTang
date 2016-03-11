//
//  TitleBarView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/8.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class TitleBarView: UIView {
    
    private let reusableCell = "reusableCell"
    
    internal var categoryElements = [CategoryElement]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    private var collectionView:UICollectionView?
    private var collectionViewFlowLayout:UICollectionViewFlowLayout?
    private var indicatorView:UIScrollView?
    private var indicator:UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
        setUpIndicatorView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpCollectionView(){
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout?.minimumInteritemSpacing = 0
        collectionViewFlowLayout?.minimumLineSpacing = 0
        collectionViewFlowLayout?.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout!)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.registerClass(TitleBarViewCell.self, forCellWithReuseIdentifier: reusableCell)
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.bounces = false
        self.addSubview(collectionView!)
        
    }
    func setUpIndicatorView(){
        
        indicatorView = UIScrollView()
        indicator = UIView(frame: CGRect(x: 0, y: 7, width: self.width()/6, height: 3))
        indicator?.backgroundColor = UIColor.redColor()
        indicatorView?.addSubview(indicator!)
        indicatorView?.userInteractionEnabled = false
        indicatorView?.bounces = false
        self.addSubview(indicatorView!)
        
    }
    
    func setUpConstraints(){
        
        for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let views:[String:UIView] = ["collectionView":collectionView!,"indicatorView":indicatorView!]
        var allConstraints = [NSLayoutConstraint]()
        
        let collectionViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collectionView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += collectionViewHorizontalConstraint
        
        let indicatorViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[indicatorView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += indicatorViewHorizontalConstraint
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collectionView(30)]-0-[indicatorView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraint
        
        self.addConstraints(allConstraints)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //collectionViewFlowLayout?.itemSize.width = self.width()/6
        indicator?.frame.size.width = self.width()/6
    }
    

}

extension TitleBarView:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryElements.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCell, forIndexPath: indexPath) as! TitleBarViewCell
        let categoryElement = categoryElements[indexPath.row]
        cell.textLabel?.text = categoryElement.title
        
        return cell
    }
}
extension TitleBarView:UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.indicator?.frame.origin.x = self.width()/6 * CGFloat(indexPath.row)
        }
    }


}

extension TitleBarView:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        indicatorView?.contentOffset.x = (collectionView?.contentOffset.x)!
    }
}

extension TitleBarView:UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSizeMake(self.width()/6, 30)
        return size
    }
}
