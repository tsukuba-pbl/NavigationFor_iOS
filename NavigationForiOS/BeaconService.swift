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
    var navigations:NavigationEntity!
    var UUIDList : Array<String> = Array()
    
    //使用するビーコンのRSSI一覧
    var beaconsRssiList = Dictionary<Int, Int>() //key:minor(int val) val:rssi(int val)
    var oldbeaconsRssiList = Dictionary<Int, Int>()
    
    override init() {
        super.init()
        
    }
    
    //ナビゲーションデータをセットする
    func startBeaconReceiver(navigations : NavigationEntity){
        self.navigations = navigations
        
        //使用するビーコンのminor idのリストを取得するして、電波強度の表を作成する
        initBeaconRssiList(minor_id_list: navigations.getMinorList())
        oldbeaconsRssiList = beaconsRssiList
        
        //使用するUUIDのリストを取得
        UUIDList = navigations.getUUIDList()
        
        // ロケーションマネージャの作成.
        myLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定.
        myLocationManager.delegate = self
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 取得頻度の設定.(1mごとに位置情報取得)
        myLocationManager.distanceFilter = 1
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == .notDetermined) {
            // [認証手順1] まだ承認が得られていない場合は、認証ダイアログを表示.
            // [認証手順2] が呼び出される
            myLocationManager.requestAlwaysAuthorization()
        }
    }
    
    /*
     CoreLocationの利用許可が取れたらiBeaconの検出を開始する.
     */
    private func startMyMonitoring() {
        
        // UUIDListのUUIDを設定して、反応するようにする
        for i in 0 ..< UUIDList.count {
            
            // BeaconのUUIDを設定.
            let uuid: NSUUID! = NSUUID(uuidString: "\(UUIDList[i].lowercased())")
            
            // BeaconのIfentifierを設定.
            let identifierStr: String = "fabo\(i)"
            
            // リージョンを作成.
            myBeaconRegion = CLBeaconRegion(proximityUUID: uuid as UUID, identifier: identifierStr)
            
            // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
            myBeaconRegion.notifyEntryStateOnDisplay = false
            
            // 入域通知の設定.
            myBeaconRegion.notifyOnEntry = true
            
            // 退域通知の設定.
            myBeaconRegion.notifyOnExit = true
            
            // [iBeacon 手順1] iBeaconのモニタリング開始([iBeacon 手順2]がDelegateで呼び出される).
            myLocationManager.startMonitoring(for: myBeaconRegion)
        }
    }
    
    /*
     [認証手順2] 認証のステータスがかわったら呼び出される.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // 認証のステータスをログで表示
        switch (status) {
        case .authorizedAlways:
            // 許可がある場合はiBeacon検出を開始.
            startMyMonitoring()
            break
        case .authorizedWhenInUse:
            // 許可がある場合はiBeacon検出を開始.
            startMyMonitoring()
            break
        default:
            break
        }
    }
    
    /*
     [iBeacon 手順2]  startMyMonitoring()内のでstartMonitoringForRegionが正常に開始されると呼び出される。
     */
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        // [iBeacon 手順3] この時点でビーコンがすでにRegion内に入っている可能性があるので、その問い合わせを行う
        // [iBeacon 手順4] がDelegateで呼び出される.
        manager.requestState(for: region);
    }
    
    /*
     [iBeacon 手順4] 現在リージョン内にiBeaconが存在するかどうかの通知を受け取る.
     */
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        switch (state) {
            
        case .inside: // リージョン内にiBeaconが存在いる
            
            // [iBeacon 手順5] すでに入っている場合は、そのままiBeaconのRangingをスタートさせる。
            // [iBeacon 手順6] がDelegateで呼び出される.
            // iBeaconがなくなったら、Rangingを停止する
            manager.startRangingBeacons(in: region as! CLBeaconRegion)
            break
        default:
            break
        }
    }
    
    /*
     [iBeacon 手順6] 現在取得しているiBeacon情報一覧が取得できる.
     iBeaconを検出していなくても1秒ごとに呼ばれる.
     */
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        //使用しているビーコンだけにフィルタリングする
        let availableBeacons = beacons.filter({ navigations.isAvailableBeaconId(uuid: $0.proximityUUID.uuidString, minor_id: Int($0.minor))})
        if(availableBeacons.count > 0){
            //BeaconRssiListに格納
            for i in availableBeacons{
                let minor_id = i.minor.intValue
                var rssi = i.rssi
                if(rssi == 0){
                    rssi = -100
                }
                beaconsRssiList.updateValue(rssi, forKey: minor_id)
            }
            
            //複数あった場合は一番RSSI値の大きいビーコンを取得する
            var maxId = 0
            for i in (1 ..< availableBeacons.count){
                //使用しているUUIDのビーコン　かつ　0dBでない（ちゃんと受信できている）ビーコンであるかを判定する
                if(navigations.isAvailableBeaconId(uuid: availableBeacons[i].proximityUUID.uuidString, minor_id: availableBeacons[i].minor.intValue) && availableBeacons[i].rssi != 0){
                    if(availableBeacons[maxId].rssi < availableBeacons[i].rssi){
                        maxId = i
                    }
                }
            }
            maxRssiBeacon = availableBeacons[maxId]
        }else{
            maxRssiBeacon = nil
        }
        
    }
    
    /*
     [iBeacon イベント] iBeaconを検出した際に呼ばれる.
     */
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        // Rangingを始める (Ranginghあ1秒ごとに呼ばれるので、検出中のiBeaconがなくなったら止める)
        manager.startRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    /*
     [iBeacon イベント] iBeaconを喪失した際に呼ばれる. 喪失後 30秒ぐらいあとに呼び出される.
     */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        // 検出中のiBeaconが存在しないのなら、iBeaconのモニタリングを終了する.
        manager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    //最大RSSIのビーコンの情報を返す関数
    //flag : 存在するとき true 存在しないとき false
    //minor : minor id
    //rssi : RSSI
    //uuid : uuid
    func getMaxRssiBeacon() -> (flag : Bool, minor : Int, rssi : Int, uuid : String){
        if(maxRssiBeacon != nil && navigations.isAvailableBeaconId(uuid: maxRssiBeacon.proximityUUID.uuidString, minor_id: Int(maxRssiBeacon.minor))){
            return (true, maxRssiBeacon.minor.intValue, maxRssiBeacon.rssi, maxRssiBeacon.proximityUUID.uuidString)
        }else{
            return (false, -1, -100, "")
        }
    }
    
    //BeaconRSSIListの初期化を行う（引数は、使用するビーコンのminorの配列）
    func initBeaconRssiList(minor_id_list: [Int]){
        for i in minor_id_list{
            beaconsRssiList[i] = -100
        }
    }
    
    //平滑化関数
    func LPF(current_beacons_rssi_list: Dictionary<Int, Int>, old_beacons_rssi_list: Dictionary<Int, Int>) -> Dictionary<Int, Int> {
        var z = current_beacons_rssi_list
        let alpha = 0.7
        
        
        for i in current_beacons_rssi_list {
            let key = i.key
            let x = Double(old_beacons_rssi_list[key]!) * (1-alpha) + Double(current_beacons_rssi_list[key]!) * alpha
            z.updateValue(Int(x), forKey: key)
        }
        
        return z
    }
    
}
