//
//  BeaconService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconService : NSObject, CLLocationManagerDelegate{
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    var status:String!
    var uuid:String!
    var major:String!
    var minor:String!
    var accuracy:String!
    var rssi:String!
    var distance:String!
    var navigation:String!
    
    init(planUUID : String){
        super.init()
        
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
        let uuid:UUID! = UUID(uuidString : planUUID)
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "tsukuba.rdprj")
    }
    
    
}
