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

//MARK:定义代理委托
extension CLLocationManager:HasDelegate{
    public typealias Delegate = CLLocationManagerDelegate
}

public class RxCLLocationManagerDelegateProxy:DelegateProxy<CLLocationManager,CLLocationManagerDelegate>,DelegateProxyType,CLLocationManagerDelegate{
    //设置代理委托
    public init(locationManager:CLLocationManager){
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register {  RxCLLocationManagerDelegateProxy(locationManager: $0)}
    }
    
    //定义两个订阅者
    internal lazy var didUpdateLocationsSubject = PublishSubject<[CLLocation]>()
    internal lazy var didFailWithErrorSubject = PublishSubject<Error>()
    
    
    /// 定位失败的代理方法
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        (_forwardToDelegate != nil) ? locationManager(manager, didFailWithError: error): didFailWithErrorSubject.onNext(error);
    }
    

    /// 定位成功的代理方法
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        (_forwardToDelegate != nil) ? locationManager(manager, didUpdateLocations: locations) : didUpdateLocationsSubject.onNext(locations)
    }
    
    deinit {
        self.didUpdateLocationsSubject.on(.completed)
        self.didFailWithErrorSubject.on(.completed)
    }
}

//MARK:拓展CLLocationManager,将前面的代理委托类关联起来，将定位相关的```delegate```方法转化为可观察序列

extension Reactive where Base : CLLocationManager{
    
    
    /// reactive 包装为委托
    public var delegate:DelegateProxy<CLLocationManager,CLLocationManagerDelegate>{
        return RxCLLocationManagerDelegateProxy.proxy(for: base);
    }
    
    // 包装CLLocationManager的代理方法
    public var didUpdateLocations:Observable<[CLLocation]>{
        return RxCLLocationManagerDelegateProxy.proxy(for: base).didUpdateLocationsSubject.asObserver()
    }
    
    public var didFailWithError:Observable<Error>{
        return RxCLLocationManagerDelegateProxy.proxy(for: base).didFailWithErrorSubject.asObserver()
    }
    
    //MARK:根据版本判断显示
    #if os(iOS) || os(macOS)
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didFinishDeferredUpdatesWithError: Observable<Error?> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didFinishDeferredUpdatesWithError:)))
            .map { a in
                return try castOptionalOrThrow(Error.self, a[1])
        }
    }
    #endif
    
    #if os(iOS)
    
    // MARK: Pausing Location Updates
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didPauseLocationUpdates: Observable<Void> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManagerDidPauseLocationUpdates(_:)))
            .map { _ in
                return ()
        }
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didResumeLocationUpdates: Observable<Void> {
        return delegate.methodInvoked( #selector(CLLocationManagerDelegate
            .locationManagerDidResumeLocationUpdates(_:)))
            .map { _ in
                return ()
        }
    }
    
    // MARK: Responding to Heading Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didUpdateHeading: Observable<CLHeading> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didUpdateHeading:)))
            .map { a in
                return try castOrThrow(CLHeading.self, a[1])
        }
    }
    
    // MARK: Responding to Region Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didEnterRegion: Observable<CLRegion> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didEnterRegion:)))
            .map { a in
                return try castOrThrow(CLRegion.self, a[1])
        }
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didExitRegion: Observable<CLRegion> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didExitRegion:)))
            .map { a in
                return try castOrThrow(CLRegion.self, a[1])
        }
    }
    
    #endif
    
    #if os(iOS) || os(macOS)
    
    /**
     Reactive wrapper for `delegate` message.
     */
    @available(OSX 10.10, *)
    public var didDetermineStateForRegion: Observable<(state: CLRegionState,
        region: CLRegion)> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didDetermineState:for:)))
            .map { a in
                let stateNumber = try castOrThrow(NSNumber.self, a[1])
                let state = CLRegionState(rawValue: stateNumber.intValue)
                    ?? CLRegionState.unknown
                let region = try castOrThrow(CLRegion.self, a[2])
                return (state: state, region: region)
        }
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var monitoringDidFailForRegionWithError:
        Observable<(region: CLRegion?, error: Error)> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:monitoringDidFailFor:withError:)))
            .map { a in
                let region = try castOptionalOrThrow(CLRegion.self, a[1])
                let error = try castOrThrow(Error.self, a[2])
                return (region: region, error: error)
        }
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didStartMonitoringForRegion: Observable<CLRegion> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didStartMonitoringFor:)))
            .map { a in
                return try castOrThrow(CLRegion.self, a[1])
        }
    }
    
    #endif
    
    #if os(iOS)
    
    // MARK: Responding to Ranging Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didRangeBeaconsInRegion: Observable<(beacons: [CLBeacon],
        region: CLBeaconRegion)> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didRangeBeacons:in:)))
            .map { a in
                let beacons = try castOrThrow([CLBeacon].self, a[1])
                let region = try castOrThrow(CLBeaconRegion.self, a[2])
                return (beacons: beacons, region: region)
        }
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var rangingBeaconsDidFailForRegionWithError:
        Observable<(region: CLBeaconRegion, error: Error)> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:rangingBeaconsDidFailFor:withError:)))
            .map { a in
                let region = try castOrThrow(CLBeaconRegion.self, a[1])
                let error = try castOrThrow(Error.self, a[2])
                return (region: region, error: error)
        }
    }
    
    // MARK: Responding to Visit Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    @available(iOS 8.0, *)
    public var didVisit: Observable<CLVisit> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didVisit:)))
            .map { a in
                return try castOrThrow(CLVisit.self, a[1])
        }
    }
    
    #endif
    
    // MARK: 修改定位权限的响应
    
    /**
     修改定位权限的响应
     */
    public var didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didChangeAuthorization:)))
            .map { a in
                let number = try castOrThrow(NSNumber.self, a[1])
                return CLAuthorizationStatus(rawValue: Int32(number.intValue))
                    ?? .notDetermined
        }
    }
}


// MARK:添加的拓展方法
fileprivate func castOrThrow<T>(_ resultType:T.Type,_ object:Any) throws -> T{
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

fileprivate func castOptionalOrThrow<T>(_ resultType:T.Type,_ object:Any) throws -> T?{
    if NSNull().isEqual(object) {
        return nil
    }
    
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}























