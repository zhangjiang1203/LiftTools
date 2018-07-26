//
//  ZJSubscript+Int.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/23.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation

extension Int {
    
    /// 返回十进制数字从右到左第n个数字
    ///
    /// - Parameter index: 下标n
    subscript(index:Int) -> Int {
        var decimalBase = 1
        for _ in 1...index {
            decimalBase *= 10;
        }
        return (self / decimalBase) % 10
    }
}
