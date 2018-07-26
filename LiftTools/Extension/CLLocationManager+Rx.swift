//
//  CLLocationManager+Rx.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/6/12.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation
//使用方法
/*
 ZJRxLocationManager.default
                    .location
                    .asObservable()
                    .subscribe(onNext: { (location) in
                        //定位地图中心，停止定位
                        self.mapView?.centerCoordinate = location.coordinate
                        ZJRxLocationManager.default.locationManager.stopUpdatingLocation();
                        ZJRxLocationManager.default.detailAddress = { (address,city) in
                            print(address + "  " + city);
                        }
                    }).disposed(by: disposeBag);
*/

class ZJRxLocationManager:NSObject {
    
    private let dispose = DisposeBag()
    
    static let `default` = ZJRxLocationManager()
    
    /// 定位权限序列
    private (set) var authorized:Driver<Bool>
    
    /**
     * 定位信息
     *
     * 经度：currLocation.coordinate.longitude
     * 纬度：currLocation.coordinate.latitude
     * 海拔：currLocation.altitude
     * 方向：currLocation.course
     * 速度：currLocation.speed
     *  ……
     */
    /// 定位信息序列
    private (set) var location:Driver<CLLocation>
    
    /// 具体位置信息和城市信息
    var detailAddress:((String,String)->())?

    /// 定位管理器
    let locationManager = CLLocationManager()
    
    override init(){
        
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //设置间隔距离内更新定位信息,定位精度要求越高，distanceFilter的值越小，耗电量越大
        self.locationManager.distanceFilter = 100.0;
        // 获取定位权限
        authorized = Observable.deferred({ [weak locationManager] in
            let status = CLLocationManager.authorizationStatus()
            guard let locationManager = locationManager else{
                return Observable.just(status)
            }
            return locationManager.rx.didChangeAuthorizationStatus.startWith(status)
        }).asDriver(onErrorJustReturn: CLAuthorizationStatus.notDetermined)
            .map({
                switch $0{
                case .authorizedAlways:
                    return true
                default:
                    return false
                }
            })
        
        // 获取定位信息
        location = locationManager.rx.didUpdateLocations
                .asDriver(onErrorJustReturn: [])
                .flatMap{
                    return $0.last.map(Driver.just) ?? Driver.empty()
                }.map{$0}

        //发送授权申请
        locationManager.requestAlwaysAuthorization()
        //开启定位服务
        locationManager.startUpdatingLocation();
        // 在 init 中 有四个阶段的安全检查, 这里违背了第四个检查
        // 初始化 编译的过程的四个安全检查
        // 1. 在调用父类初始化之前 必须给子类特有的属性设置初始值, 只有在类的所有存储属性状态都明确后, 这个对象才能被初始化
        // 2. 先调用父类的初始化方法,  再 给从父类那继承来的属性初始化值, 不然这些属性值 会被父类的初始化方法覆盖
        // 3. convenience 必须先调用 designated 初始化方法, 再 给属性初始值. 不然设置的属性初始值会被 designated 初始化方法覆盖
        // 4. 在第一阶段完成之前, 不能调用实类方法, 不能读取属性值, 不能引用self
        super.init()
        self.getDetailAddress()
    }
    
    func getDetailAddress() {
        //获取反地理编码
        location.asObservable().subscribe(onNext: {[weak self] (loc) in
            //反地理编码获得具体信息
            let geoCoder = CLGeocoder.init()
            var detailAdd = ""
            geoCoder.reverseGeocodeLocation(loc) { (placeMarks, error) in
                guard let placemarks = placeMarks else{
                    return
                }
                let place:CLPlacemark = placemarks.first!
                detailAdd =  ((place.addressDictionary?["FormattedAddressLines"] as? Array)?.first)!;
                if (self?.detailAddress != nil){
                    self?.detailAddress!(detailAdd,place.locality!);
                }
            }
        }).disposed(by: dispose)
    }
}
