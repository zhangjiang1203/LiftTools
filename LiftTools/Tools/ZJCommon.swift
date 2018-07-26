//
//  ZJCommonAPI.swift
//  HangtianCar
//
//  Created by zitang on 2018/5/28.
//  Copyright © 2018年 zitang. All rights reserved.
//

import Foundation


//屏幕高度
let kScreenWidth = UIScreen.main.bounds.size.width;
//屏幕宽度
let kScreenHeight = UIScreen.main.bounds.size.height;

/// 导航栏高度
let kNavBarH : CGFloat = kScreenHeight == 812 ? 88 : 64

/// tabbar高度
let kTabBarH : CGFloat = kScreenHeight == 812 ? 83 : 49

//不同屏幕尺寸字体适配（375，667是因为目前苹果开发一般用IPHONE6做中间层 如果不是则根据实际情况修改）
//相对于iPhone6的宽度比例
let screenWidthRatio:CGFloat =  kScreenWidth / 375.0;
let screenHeightRatio:CGFloat = kScreenHeight / 667.0;

//其它屏幕尺寸相对iphone6的宽度
func kWithRelIPhone6(width: CGFloat) -> CGFloat {
    return width * kScreenWidth / 750.0;
}

//其它屏幕尺寸相对iphone6的高度
func kHeightRelIPhone6(width: CGFloat) -> CGFloat {
    return width * kScreenHeight / 1334.0;
}

// MARK: - 打印
func Mprint<T>(_ message: T,_ file: String = #file,_ methodName: String = #function,_ lineNumber: Int = #line) {
    #if DEBUG
    print("\nfunc:\(methodName)\n\(message)\n")
    #endif
}
