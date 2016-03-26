//
//  MainViewCollectionViewCell.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/8.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewCollectionViewCell: UICollectionViewCell {
    private let reusableTableViewCell = "topicTableViewCell"
    private var tableView:UITableView?
    
    internal var topicList:[Topic]? {
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        setUpSubview()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubview()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpSubview(){
        tableView = UITableView()
        tableView?.registerClass(TopicTableViewCell.self, forCellReuseIdentifier: reusableTableViewCell)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 100
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.contentView.addSubview(tableView!)

    }
    func setUpConstraints(){
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        let views:[String:UIView] = ["tableView":tableView!]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[tableView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        self.contentView.addConstraints(allConstraints)
    }
    
}
extension MainViewCollectionViewCell:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicList == nil {
            return 0
        } else {
            return (topicList?.count)!
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableTableViewCell, forIndexPath: indexPath) as! TopicTableViewCell
        let topicdata = topicList![indexPath.row]
        cell.topicImageView?.sd_setImageWithURL(topicdata.photoURL, placeholderImage: UIImage(named: "topicpic"))
        cell.topicTitleLabel?.text = topicdata.title
        cell.topicLikeLabel?.text = "♡\(topicdata.likes)"
        return cell
    }
}

extension MainViewCollectionViewCell:UITableViewDelegate {
    
}
