//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreLocation

class NavigationViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    let fruits = ["リンゴ", "みかん", "ぶどう"]
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ロケーションマネージャーを作成する
        self.trackLocationManager = CLLocationManager();
        
        //デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        //セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        //認証を得ていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.notDetermined){
            self.trackLocationManager.requestAlwaysAuthorization();
        }
        
        // BeaconのUUIDを設定.
        let uuid:UUID! = UUID(uuidString: "12345678-1234-1234-1234-123456789ABC")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "net.noumenon-th")
    }
    
    //位置認証のステータスが変更された時に呼ばれる
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // 認証のステータス
        var statusStr = "";
        print("CLAuthorizationStatus: \(statusStr)")
        
        // 認証のステータスをチェック
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
            self.status.text   = "位置情報を許可していません"
        case .authorized:
            statusStr = "Authorized"
            self.status.text   = "位置情報認証OK"
        default:
            break;
        }
        
        print(" CLAuthorizationStatus: \(statusStr)")
        
        //観測を開始させる
        trackLocationManager.startMonitoring(for: self.beaconRegion)
        
    }
    
    //観測の開始に成功すると呼ばれる
    private func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        
        print("didStartMonitoringForRegion");
        
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        trackLocationManager.requestState(for: self.beaconRegion);
    }
    
    //領域内にいるかどうかを判定する
    private func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion!) {
        
        switch (state) {
            
        case .inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
            
            trackLocationManager.startRangingBeacons(in: beaconRegion);
            // →(didRangeBeacons)で測定をはじめる
            break;
            
        case .outside:
            
            // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        case .unknown:
            
            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        default:
            
            break;
            
        }
    }
    
    //領域に入った時
    private func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        
        // →(didRangeBeacons)で測定をはじめる
        self.trackLocationManager.startRangingBeacons(in: self.beaconRegion)
        self.status.text = "didEnterRegion"
        
        //sendLocalNotificationWithMessage("領域に入りました")
        
    }
    
    //領域から出た時
    private func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        
        //測定を停止する
        self.trackLocationManager.stopRangingBeacons(in: self.beaconRegion)
        
        reset()
        
        //sendLocalNotificationWithMessage("領域から出ました")
        
    }
    
    //観測失敗
    private func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        
        print("monitoringDidFailForRegion \(error)")
        
    }
    
    //通信失敗
    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        print("didFailWithError \(error)")
        
    }
    
    //領域内にいるので測定をする
    private func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: NSArray!, inRegion region: CLBeaconRegion!) {
        print(beacons)
        
        //ビーコンが一つも取得できてないとき
        if(beacons.count == 0) {
            reset()
            return
        }
        
        //複数あった場合は一番RSSI値の大きいビーコンを取得する
        var maxId = 0
        for i in (1 ..< beacons.count){
            if((beacons[maxId] as! CLBeacon).rssi < (beacons[i] as! CLBeacon).rssi){
                maxId = i
            }
        }
        var maxRssiBeacon = beacons[maxId] as! CLBeacon
        
        
        /*
         beaconから取得できるデータ
         proximityUUID   :   regionの識別子
         major           :   識別子１
         minor           :   識別子２
         proximity       :   相対距離
         accuracy        :   精度
         rssi            :   電波強度
         */
        //RSSI最大のビーコンの情報を表示する
        if (maxRssiBeacon.proximity == CLProximity.unknown) {
            self.distance.text = "Unknown Proximity"
            reset()
            return
        } else if (maxRssiBeacon.proximity == CLProximity.immediate) {
            self.distance.text = "Immediate"
        } else if (maxRssiBeacon.proximity == CLProximity.near) {
            self.distance.text = "Near"
        } else if (maxRssiBeacon.proximity == CLProximity.far) {
            self.distance.text = "Far"
        }
        self.status.text   = "領域内です"
        self.uuid.text     = maxRssiBeacon.proximityUUID.uuidString
        self.major.text    = "\(maxRssiBeacon.major)"
        self.minor.text    = "\(maxRssiBeacon.minor)"
        self.accuracy.text = "\(maxRssiBeacon.accuracy)"
        self.rssi.text     = "\(maxRssiBeacon.rssi)"
        
    }
    
    func reset(){
        self.status.text   = "none"
        self.uuid.text     = "none"
        self.major.text    = "none"
        self.minor.text    = "none"
        self.accuracy.text = "none"
        self.rssi.text     = "none"
        self.distance.text = "none"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
