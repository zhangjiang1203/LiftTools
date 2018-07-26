//
//  UIView+Ex.swift
//  HangtianCar
//
//  Created by zitang on 2018/6/7.
//  Copyright © 2018年 zhangjiang. All rights reserved.
//

import Foundation

public extension UIView{
    // MARK: - 尺寸相关
    var zj_x:CGFloat{
        get{
            return self.frame.origin.x
        } set{
            self.frame.origin.x = newValue
        }
    }
    
    var zj_y:CGFloat{
        get{
            return self.frame.origin.y
        }set{
            self.frame.origin.y = newValue
        }
    }
    
    var zj_width:CGFloat{
        get{
            return self.frame.size.width
        }set{
            self.frame.size.width = newValue
        }
    }
    
    var zj_height:CGFloat{
        get{
            return self.frame.size.height
        }set{
            self.frame.size.height = newValue
        }
    }
    
    var zj_size:CGSize{
        get{
            return self.frame.size
        }set{
            self.frame.size = newValue
        }
    }
    var zj_centerX:CGFloat{
        get{
            return self.center.x
        }set{
            self.zj_centerX = newValue
        }
    }
    var zj_centerY:CGFloat{
        get{
            return self.center.y
        }set{
            self.zj_centerY = newValue
        }
    }
    // MARK: - 尺寸裁剪相关
    /// 添加圆角  radius: 圆角半径
    func addRounded(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    /// 添加部分圆角(有问题右边且不了) corners: 需要实现为圆角的角，可传入多个 radius: 圆角半径
    func addRounded(radius:CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer;
    }
    
    // MARK: - 添加边框
    /// 添加边框 width: 边框宽度 默认黑色
    func addBorder(width : CGFloat) { // 黑框
        self.layer.borderWidth = width;
        self.layer.borderColor = UIColor.black.cgColor;
    }
    /// 添加边框 width: 边框宽度 borderColor:边框颜色
    func addBorder(width : CGFloat, borderColor : UIColor) { // 颜色自己给
        self.layer.borderWidth = width;
        self.layer.borderColor = borderColor.cgColor;
    }
    /// 添加圆角和阴影
    func addRoundedOrShadow(radius:CGFloat)  {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1 // 不透明度
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
}

