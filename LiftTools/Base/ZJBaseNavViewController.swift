//
//  ZJBaseNavViewController.swift
//  HangtianCar
//
//  Created by zitang on 2018/6/8.
//  Copyright © 2018年 zhangjiang. All rights reserved.
//

import UIKit

class ZJBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = .white;
        self.navigationBar.isTranslucent = false;
    
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated);
    }

    

}
