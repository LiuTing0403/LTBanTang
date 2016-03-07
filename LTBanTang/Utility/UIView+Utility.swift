//
//  UIView+Utility.swift
//  LTBanTang
//
//  Created by liu ting on 16/3/6.
//  Copyright © 2016年 liu ting. All rights reserved.
//

import UIKit

extension UIView {
    
    func width()->CGFloat{
        return self.bounds.width
    }
    
    func height()->CGFloat {
        return self.bounds.height
    }
    
    func centerX()->CGFloat {
        return self.center.x
    }
    
    func centerY()->CGFloat {
        return self.center.y
    }
    
    func maxX()->CGFloat {
        return CGRectGetMaxX(self.frame)
    }
    
    func maxY()->CGFloat {
        return CGRectGetMaxY(self.frame)
    }
}
