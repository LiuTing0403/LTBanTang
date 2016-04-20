//
//  MianViewController + DelegateAndDataSource.swift
//  LTBanTang
//
//  Created by liu ting on 16/4/19.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: Data Source
extension MainViewController:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCollectionViewCell, forIndexPath: indexPath) as! MainViewCollectionViewCell
        cell.topicList = topics[indexPath.row]
        return cell
    }
}
//MARK: Flow Layout
extension MainViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
}
//MARK: Collection View Delegate
extension MainViewController:UICollectionViewDelegate {
    
}

//MARK: Scroll View Delegate
extension MainViewController:UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        dragging = false
        let itemIndexPath = NSIndexPath(forItem: Int(scrollView.contentOffset.x / self.view.width()), inSection: 0)
        
        if topics[itemIndexPath.row].count == 0 {
            getNewTopicAtIndex(itemIndexPath.row, requestPage: requestPage, extend: categoryElements[itemIndexPath.row].extend)
        }
        self.titleBarView.selectItemAtIndexPath(itemIndexPath.row)
        currentCategoryIndex = itemIndexPath.row
        requestPage = 0
    }
    
}

extension MainViewController:TitleBarViewDelegate {
    func numberOfTitlesInTitleBarView(titleBarView: TitleBarView) -> Int {
        return categoryElements.count
    }
    func titleForItemAtIndex(titleBarView: TitleBarView, index:Int) -> String {
        return categoryElements[index].title
    }
    
    func didSelectedTitleAtIndex(titleBarView: TitleBarView, indexPath:NSIndexPath) {
        print("did selected category at index (\(index))")
        getNewTopicAtIndex(indexPath.row, requestPage: requestPage,extend: categoryElements[indexPath.row].extend)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        currentCategoryIndex = indexPath.row
        requestPage = 0
    }
}

extension MainViewController:CycleScrollViewDelegate {
    func numberOfItemsInCycleScrollView(cycleScrollView:CycleScrollView) -> Int {
        return banners.count
    }
    func imagesForCycleScrollView(cycleScrollView:CycleScrollView)-> [UIImage] {
        var imageGroup = [UIImage]()
        for banner in banners {
            let image = LibraryAPI.sharedInstance.downloadImage(banner.photoURL)
            imageGroup.append(image)
        }
        return imageGroup
    }
    func cycleScrollView(cycleScrollView:CycleScrollView, didSelectedItemAtIndex index:Int) {
        print("did selected banner at index \(index)")
    }
}