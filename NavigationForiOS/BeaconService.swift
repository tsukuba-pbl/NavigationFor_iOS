//
//  BeaconService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconService: NSObject, CLLocationManagerDelegate {
    
    var myLocationManager:CLLocationManager!
    var myBeaconRegion:CLBeaconRegion!
    var beaconRegions = [CLBeaconRegion]()
    var maxRssiBeacon:CLBeacon! //最大RSSIのビーコン
    
    let UUIDList = [
        "12345678-1234-1234-1234-123456789ABC"
        ]
    
    override init() {
        super.init()
        
        // ロケーションマネージャの作成.
        myLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定.
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 取得頻度の設定.(1mごとに位置情報取得)
        myLocationManager.distanceFilter = 1
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status != CLAuthorizationStatus.authorizedAlways) {
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            myLocationManager.requestAlwaysAuthorization()
        }
        
        for i in 0 ..< UUIDList.count {
            
            // BeaconのUUIDを設定.
            let uuid:NSUUID! = NSUUID(uuidString: "\(UUIDList[i].lowercased())")
            
            // BeaconのIfentifierを設定.
            let identifierStr:String = "akabeacon" + i.description
            
            // リージョンを作成.
            myBeaconRegion = CLBeaconRegion(proximityUUID: uuid as UUID, major: CLBeaconMajorValue(1), minor: CLBeaconMinorValue(1), identifier: identifierStr)
            
            // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
            myBeaconRegion.notifyEntryStateOnDisplay = false
            
            // 入域通知の設定.
            myBeaconRegion.notifyOnEntry = true
            
            // 退域通知の設定.
            myBeaconRegion.notifyOnExit = true
            
            beaconRegions.append(myBeaconRegion)
            
            myLocationManager.startMonitoring(for: myBeaconRegion)
        }
        
    }
    
    /*
     (Delegate) 認証のステータスがかわったら呼び出される.
     */
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // 認証のステータスをログで表示
        var statusStr = "";
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
        case .authorizedAlways:
            statusStr = "AuthorizedAlways"
        case .authorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
     
        for region in beaconRegions {
            manager.startMonitoring(for: region)
        }
    }
    
    /*
     STEP2(Delegate): LocationManagerがモニタリングを開始したというイベントを受け取る.
     */
    private func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion) {

        // STEP3: この時点でビーコンがすでにRegion内に入っている可能性があるので、その問い合わせを行う
        // (Delegate didDetermineStateが呼ばれる: STEP4)
        manager.requestState(for: region);
    }
    
    /*
     STEP4(Delegate): 現在リージョン内にいるかどうかの通知を受け取る.
     */
    private func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        
        if(state == .inside){
          
            // STEP5: すでに入っている場合は、そのままRangingをスタートさせる
            // (Delegate didRangeBeacons: STEP6)
            manager.startRangingBeacons(in: region as! CLBeaconRegion)
        }
    }
    
    /*
     STEP6(Delegate): ビーコンがリージョン内に入り、その中のビーコンをNSArrayで渡される.
     */
    private func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        // 範囲内で検知されたビーコンはこのbeaconsにCLBeaconオブジェクトとして格納される
        // rangingが開始されると１秒毎に呼ばれるため、beaconがある場合のみ処理をするようにすること.
        if(beacons.count > 0){
            
            //複数あった場合は一番RSSI値の大きいビーコンを取得する
            var maxId = 0
            for i in (1 ..< beacons.count){
                if((beacons[maxId] as! CLBeacon).rssi < (beacons[i] as! CLBeacon).rssi){
                    maxId = i
                }
            }
            maxRssiBeacon = beacons[maxId] as! CLBeacon
        }else{
            maxRssiBeacon = nil
        }
    }
    
    /*
     (Delegate) リージョン内に入ったというイベントを受け取る.
     */
    private func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        // Rangingを始める
        manager.startRangingBeacons(in: region as! CLBeaconRegion)
        
    }
    
    /*
     (Delegate) リージョンから出たというイベントを受け取る.
     */
    private func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        // Rangingを停止する
        manager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    //最大RSSIのビーコンの情報を返す関数
    //flag : 存在するとき true 存在しないとき false
    //minor : minor id
    //rssi : RSSI
    //uuid : uuid
    func getMaxRssiBeacon() -> (flag : Bool, minor : Int, rssi : Int, uuid : String){
        if(maxRssiBeacon != nil){
            return (true, maxRssiBeacon.minor.intValue, maxRssiBeacon.rssi, maxRssiBeacon.proximityUUID.uuidString)
        }else{
            return (false, -1, -100, "")
        }
    }
    
    //使用しているビーコンのUUIDを返す関数
    func getUsingUUID() -> (Array<String>){
        return UUIDList
    }
    
}
