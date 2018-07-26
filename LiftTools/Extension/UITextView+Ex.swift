//
//  UITextView+Ex.swift
//  HangtianCar
//
//  Created by zitang on 2018/6/8.
//  Copyright © 2018年 zhangjiang. All rights reserved.
//

import Foundation

var placeKey = "placeholder"
extension UITextView:UITextViewDelegate{
    var placeHolderTextView:UITextView?{
        set{
            objc_setAssociatedObject(self, &placeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let holder = objc_getAssociatedObject(self, &placeKey) as? UITextView{
                return holder;
            }
            return nil
        }
    }
    
    
    func setPlacerHolder(placeHolder:String,color:UIColor?)  {
        if self.placeHolderTextView == nil  {
            self.delegate = self;
            let textView = UITextView.init(frame: self.bounds);
            textView.autoresizingMask = .flexibleHeight;
            textView.font = self.font;
            textView.backgroundColor = .clear
            textView.textColor = (color != nil) ? color : UIColor.gray;
            textView.isUserInteractionEnabled = false;
            textView.text = placeHolder;
            textView.isHidden = self.text.count>0;
            self.addSubview(textView);
            self.placeHolderTextView = textView;
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.placeHolderTextView?.isHidden = textView.text.count > 0;
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.placeHolderTextView?.isHidden = textView.text.count > 0;
    }
    
}
