//
//  TitleBarView.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/8.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

protocol TitleBarViewDelegate {
    func numberOfTitlesInTitleBarView(titleBarView: TitleBarView) -> Int
    func titleForItemAtIndex(titleBarView: TitleBarView, index:Int) -> String
    func didSelectedTitleAtIndex(titleBarView: TitleBarView, indexPath:NSIndexPath)
}

class TitleBarView: UIView {
    
    private let reusableCell = "reusableCell"
    var delegate:TitleBarViewDelegate? {
        didSet{
            self.reloadAllData()
        }
    }
    
   // private var categoryElements = [CategoryElement]()
    
    private var collectionView:UICollectionView!
    private var collectionViewFlowLayout:UICollectionViewFlowLayout!
    private var indicatorView = UIScrollView()
    private var indicator = UIView()
    private var numberOfCellsInView = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
        setUpIndicatorView()
        setUpConstraints()

    }
    
    override func awakeFromNib() {
        setUpCollectionView()
        setUpIndicatorView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setUpCollectionView(){
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(TitleBarViewCell.self, forCellWithReuseIdentifier: reusableCell)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        self.addSubview(collectionView)
        
    }
    func setUpIndicatorView(){
        
        indicatorView = UIScrollView()
        indicator = UIView(frame: CGRect(x: 0, y: self.height() - 3, width: self.width()/CGFloat(numberOfCellsInView), height: 3))
        indicator.backgroundColor = UIColor.redColor()
        indicatorView.addSubview(indicator)
        indicatorView.userInteractionEnabled = false
        indicatorView.bounces = false
        self.addSubview(indicatorView)
        
    }
    
    func setUpConstraints(){
        
        for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let views:[String:UIView] = ["collectionView":collectionView,"indicatorView":indicatorView]
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
    
    func reloadAllData(){
        self.collectionView.reloadData()
        if let delegate = delegate {
            numberOfCellsInView = min(delegate.numberOfTitlesInTitleBarView(self), 6)
            indicator.frame = CGRect(x: 0, y: 0, width: self.width()/CGFloat(numberOfCellsInView), height: 3)
        }
    }
    
    func selectItemAtIndexPath(index:Int){
        collectionView.selectItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0), animated: true, scrollPosition: .CenteredHorizontally)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.indicator.frame.origin.x = self.width()/CGFloat(self.numberOfCellsInView) * CGFloat(index)
        }
        print("set select item for title bar view")
    }
    

}

extension TitleBarView:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let delegate = self.delegate {
            return delegate.numberOfTitlesInTitleBarView(self)
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCell, forIndexPath: indexPath) as! TitleBarViewCell
        if let delegate = self.delegate {
            cell.textLabel?.text = delegate.titleForItemAtIndex(self, index: indexPath.row)
        }
        
        return cell
    }
}
//MARK: Collection View Delegate
extension TitleBarView:UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        if let delegate = self.delegate {
            delegate.didSelectedTitleAtIndex(self, indexPath: indexPath)
        }
        UIView.animateWithDuration(0.5) { () -> Void in
            self.indicator.frame.origin.x = self.width()/CGFloat(self.numberOfCellsInView) * CGFloat(indexPath.row)
        }
//        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
//            self.indicator.frame.origin.x = self.width()/CGFloat(self.numberOfCellsInView) * CGFloat(indexPath.row)
//            }) { (finished) in
//                
//        }
        
    }
}

extension TitleBarView:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        indicatorView.contentOffset.x = collectionView.contentOffset.x
        
        print("title bar view did scroll")
    }
    
    
}

extension TitleBarView:UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSizeMake(self.width()/6, 30)
        return size
    }
}
