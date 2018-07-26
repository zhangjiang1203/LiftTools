//
//  ZJRxAlamofire.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/15.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import Alamofire

/*
 usage:
//配合使用的类库
 pod 'RxSwift'
 pod 'RxCocoa'
 pod 'RxAlamofire'
 pod 'MBProgressHUD', '~> 1.1.0'

 let request = RequestForm.getRequest("https://www.douban.com/j/app/radio/channels",
                                      parameters: nil,
                                      header: nil,
                                      hud: false);
 可省略为
 let request = RequestForm.getRequest("https://www.douban.com/j/app/radio/channels");

 ZJRxAlamofire.request(requestBody: request)
     .map({ Data in  //转化请求的信息模型
        return Data;
     })
     .mapObject(type: DouBanModel.self)
     .observeOn(MainScheduler.instance)
     .subscribe(onNext: { (model) in
     print("拿到的model===%@===",model)
     }, onError: { (error) in
     print("出错信息==%@",error.localizedDescription)
     }).disposed(by: disposeBag)
 */
//定义全局的网络监控
let manager = NetworkReachabilityManager(host: "www.baidu.com");

class ZJRxAlamofire {
    
    /// 网络请求
    ///
    /// - Parameter requestBody: 请求设置
    /// - Returns: 返回的请求数据
    static func request(requestBody:RequestFormConvertible) -> Observable<Any?> {
        if requestBody.hud!{
            SVProgressHUD.show()
        }
        return Observable.create({ (obsever) in
            return requestJSON(requestBody.method,
                               requestBody.url,
                               parameters: requestBody.parameters,
                               encoding: requestBody.encoding,
                               headers: requestBody.header)
                .subscribe(onNext: { (response,data) in
                    //判断响应结果状态码
                    if 200 ..< 300 ~= response.statusCode {
                        obsever.onNext(data)
                    }
                    SVProgressHUD.dismiss()
                }, onError: { (error) in
                    obsever.onError(error)
                    SVProgressHUD.dismiss()
            })
        })
        
    }
    
    /// 文件上传
    ///
    /// - Parameters:
    ///   - fileURL: 上传文件URL地址
    ///   - requestBody:上传URL
    /// - Returns: 返回UploadRequest
    static func uploadFile(_ fileURL:URL, requestBody:RequestFormConvertible) -> Observable<UploadRequest> {
        let url = try! URLRequest.init(url: requestBody.url,
                                       method: requestBody.method,
                                       headers: requestBody.header)
        return upload(fileURL, urlRequest: url)
    }
    
    /// 文件下载
    ///
    /// - Parameters:
    ///   - url: 请求下载的地址
    ///   - filePath: 下载文件的地址,可为空，有默认地址
    /// - Returns: 返回的DownloadRequest
    static func downLoadFile(_ url:URL,filePath:URL?) -> Observable<DownloadRequest>{
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            var fileURL:URL
            if (filePath != nil) {
                fileURL = (filePath?.appendingPathComponent(response.suggestedFilename!))!
            }else{
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                fileURL = (documentsURL.appendingPathComponent(response.suggestedFilename!))
            }
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return download(URLRequest.init(url: url), to: destination)
    }
    
    /// 监控网路状态变化
    ///
    /// - Returns: 监控网络状态变化的值 0 网络不可用 1 网络未知 2 蜂窝数据 3 wifi
    static func addNetWorkStateObserver()->Observable<NSInteger> {
        return Observable.create({ (observer) in
            manager?.listener = { status in
                var bage = 0;
                switch status {
                case .notReachable:
                    bage = 0;
                case .unknown:
                    bage = 1;
                case .reachable(.wwan):
                    bage = 2;
                case .reachable(.ethernetOrWiFi):
                    bage = 3;
                }
                observer.onNext(bage);
            }
            manager?.startListening();
            return Disposables.create()
        })
    }
}
