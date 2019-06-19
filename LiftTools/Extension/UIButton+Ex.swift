//
//  UIButton+Ex.swift
//  HangtianCar
//
//  Created by zitang on 2018/6/7.
//  Copyright © 2018年 zitang. All rights reserved.
//

import Foundation


extension UIButton{
    //枚举图片的位置
    enum ButtonImageEdgeInsetsStyle {
        case top    //上图下文字
        case left   //左图右文字
        case bottom //下图上文字
        case right  //右图左文字
    }
    
    // style:图片位置 space:图片与文字的距离
    func layoutButtonImageEdgeInsetsStyle(style:ButtonImageEdgeInsetsStyle,space:CGFloat) {
        let imageWidth:CGFloat = (self.imageView?.frame.size.width)!
        let imageHeight:CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth:CGFloat = 0
        var labelHeight:CGFloat = 0
        
        labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
        labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        
        var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -labelWidth-space/2.0, bottom: 0, right: labelWidth+space/2.0)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}

