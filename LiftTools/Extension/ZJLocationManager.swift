//
//  ZJLocationManager.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/6/12.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import CoreLocation

class ZJLocationManager : NSObject,CLLocationManagerDelegate{
    
    /// 市
    var city : String = ""

    /// 详情地址
    var detailAdd :String?
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
    var currentLocation:CLLocation?
    
    var locationSuccess :((CLLocation)->())?
    
    
    private let locationManager =  CLLocationManager()
    
    static let `default` = ZJLocationManager();
    
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //设置间隔距离内更新定位信息,定位精度要求越高，distanceFilter的值越小，耗电量越大
        self.locationManager.distanceFilter = 100.0;
        self.checkLocationPermissions()
        
    }

    /// 定位权限检测
    private func checkLocationPermissions()  {
        if CLLocationManager.locationServicesEnabled() == false {
            print("定位服务不可用")
            return;
        }
        
        //请求用户授权
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            if #available(iOS 8.0, *){
                locationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    /// 开始定位
    func startLocation(success:@escaping (CLLocation)->()) {
        self.locationSuccess = success;
        locationManager.startUpdatingLocation()
        
    }
    
    func stopLocation()  {
        locationManager.stopUpdatingLocation()
    }
    
    /// 定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位成功");
        self.currentLocation = locations.last;
        //反地理编码获得具体信息
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(locations.last!) { (placeMarks, error) in
            guard let placemarks = placeMarks else{
                return
            }
            let place:CLPlacemark = placemarks.first!
            self.detailAdd =  (place.addressDictionary?["FormattedAddressLines"] as? Array)?.first;
            if (self.locationSuccess != nil){
                self.locationSuccess!(place.location!)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败：\(error)")
    }
}
