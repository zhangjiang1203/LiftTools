//
//  ZJBaseViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/24.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZJBaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 自定义的返回按钮，右划返回上一层失效的方法
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;

    }
}

