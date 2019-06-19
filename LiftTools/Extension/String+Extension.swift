//
//  String-SLExtension.swift
//  CarBusiness-ios
//
//  Created by 李杰 on 2018/1/30.
//  Copyright © 2018年 zhangjiang. All rights reserved.
//

import Foundation


extension String {
    
    /// 汉字转拼音
    func toPinyin() -> String? {
        
        if self.isEmpty {
            return nil
        }
        
        let str = CFStringCreateMutableCopy(nil, 0, self as CFString)
    
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
        
        return str as String?
    }
    
    /// 获取汉字首字母
    func firstPinyin() -> String? {
        
        let py = self.toPinyin()
        if py?.isEmpty ?? true {
            return nil
        }
        let result = (py! as NSString).substring(to: 1).uppercased()
        return result
    }
    
    /// 身份证掩码处理
    func idCardMask() -> String? {
        // 身份证长度校验
        if self.count != 18 { return nil }
        
        let result = self.enumerated().map { (index, c) -> Character in
            if index > 2 && index < 15 { return "*"}
            return c
        }
        
        return String.init(result)
    }
    
    /// 手机号校验
    func isPhoneNumber() -> Bool {
        let regex = "^1[3,4,5,7,8]\\d{9}$"
        return isValidateByRegex(regex)
    }
    
    func isValidateByRegex(_ regex : String) -> Bool {
    
    let pre = NSPredicate.init(format: "SELF MATCHES %@", regex)
    
    return pre.evaluate(with: self)
    }
    
    /// 时间转换
    func toDate(with formatStr: String) -> String? {
        guard let value = TimeInterval.init(self) else { return nil }
        let format = DateFormatter.init()
        format.dateFormat = formatStr
        let date = Date.init(timeIntervalSince1970: value)
        return format.string(from: date)
    }
    
    /// 是否有中文
    func isHaveChineseString(regex: String) -> Bool {
        return isValidateByRegex(regex)
    }
    
    
    /// 用身份证判断性别
    ///
    /// - Returns: true 男  false 女
    func judgeMaleOrFemale() -> Bool {
        if self.count != 18 { return false }
        let startIndex = self.index(self.startIndex, offsetBy: self.count-2)
        let endIndex = self.index(startIndex, offsetBy: 1)
        let result = String(self[startIndex..<endIndex])
        if Int(result)! % 2 == 0 {
            return true
        }else{
            return false
        }
    }
    
    /// 计算文字的宽度
    func calCharacterWith(font:UIFont, height:CGFloat) -> CGFloat {
        
        let width = self.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height:height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil).size.width+5
        return width
    }
    
    /// 计算文字的高度
    func calCharacterWith(font:UIFont, width:CGFloat) -> CGFloat {
        
        let height = self.boundingRect(with: CGSize.init(width: width, height:CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil).size.height
        return height
    }
    
    
    /// 设置显示的图片的格式
    ///
    /// - Parameters:
    ///   - width: 图片的宽度
    ///   - height: 图片的高度
    /// - Returns: 返回的一个新的String
    func judgeUrlStringContant(width:CGFloat,height:CGFloat) -> String {
        
        if self.isEmpty {
            return self
        }
        if self.contains("?") {
            return self
        }else{
            let scale = UIScreen.main.scale
            return self + "?x-oss-process=image/resize,m_fixed,h_" + "\(height*scale)" + ",w_" + "\(width*scale)"
        }
    }
    
    /// 密码加密
//    var passwordEncrypt: String {
//        return (publicSalt + self + privateSalt).md5.uppercased()
//    }
    
    
    /// 密码格式验证
    func passwordVerify() -> Bool {
        return isValidateByRegex("^(?![0-9]+$)(?![a-zA-Z]+$)(?![-.!@#$%^*()+?><]+$)(?![0-9a-zA-Z]+$)(?![0-9-.!@#$%^*()+?><]+$)(?![a-zA-Z-.!@#$%^*()+?><]+$)[0-9a-zA-Z-.!@#$%^*()+?><]{6,18}$")
    }
}
