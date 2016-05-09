//
//  RootViewController.swift
//  LTBanTang
//
//  Created by liu ting on 16/4/20.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainNAV = self.storyboard!.instantiateViewControllerWithIdentifier("MainNAV")
        let discoverSB = UIStoryboard(name: "Discover", bundle: nil)
        let discoverNAV = discoverSB.instantiateViewControllerWithIdentifier("DiscoverNAV")
        let messageSB = UIStoryboard(name: "Message", bundle: nil)
        let messageNAV = messageSB.instantiateViewControllerWithIdentifier("MessageNAV")
        let profileSB = UIStoryboard(name: "Profile", bundle: nil)
        let profileNAV = profileSB.instantiateViewControllerWithIdentifier("ProfileNAV")
        
        self.viewControllers = [mainNAV, discoverNAV, UIViewController(), messageNAV, profileNAV]
        
        let tabBarItemImageNames = ["Main","Discover","Camera","Message","Profile"]

        let items = tabBarItemImageNames.map { (name) -> UITabBarItem in
            
            let item = UITabBarItem(title: nil, image: UIImage(named: name), selectedImage: nil)
            return item
        }
        
        for i in 0...4 {
            self.viewControllers![i].tabBarItem = items[i]
        }
        self.tabBar.items![2].enabled = false
        self.tabBar.translucent = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
