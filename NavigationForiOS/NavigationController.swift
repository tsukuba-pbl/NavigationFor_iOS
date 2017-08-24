//
//  NavigationController.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/23.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class NavigationController{
    var navigations : NavigationEntity? //ナビゲーション情報
    var beaconservice : BeaconService!
    var uuidList : Array<String> = []
    
    //イニシャライザ
    init(){
        //BeaconServiceのインスタンス生成
        beaconservice = BeaconService()
        
        initNavigation()
    }
    
    func initNavigation(){
        //ナビゲーションデータの読み込み
        NavigationService.getNavigationData{response in
            self.navigations = response
            self.beaconservice.startBeaconReceiver(navigations: self.navigations!)
        }
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation() -> (mode : Int, minor_id : Int, uuid : String, rssi : Int, navigation_text : String){
        var minor_id : Int!
        var uuid : String!
        var rssi : Int!
        var navigation_text : String!
        var mode = 1
        
        //現在の最大RSSIのビーコン情報を取得
        let retval = beaconservice.getMaxRssiBeacon()
        
        //存在するビーコンか判定する
        minor_id = retval.minor
        uuid = retval.uuid
        rssi = retval.rssi
        navigation_text = ""
        if(retval.flag == true){
            //ナビゲーションの更新
            //RSSI最大のビーコンのRSSIの値が-80dB以下のとき、案内が表示されるようにする
            if(isOnNavigationPoint(RSSI: retval.rssi, threshold: -80)){
                //ゴールに到着したかを判定
                if(isGoal(minor_id: retval.minor)){
                    //到着した
                    navigation_text = "Goal"
                    mode = 2
                }else{
                    //到着してない　途中のとき
                    //ルート上のビーコンか判定
                    if(isAvailableBeacon(uuid: uuid, minor_id: minor_id)){
                        navigation_text = getNavigationText(minor_id: retval.minor)
                    }else{
                        navigation_text = "ルート上から外れている可能性があります"
                    }
                }
            }else{
                navigation_text = "進もう"
            }
        }else{
            mode = -1
        }
        return (mode, minor_id, uuid, rssi, navigation_text)
    }
    
    //ナビゲーションを行うタイミングを判定する
    //目的地もしくは交差点にいるかを判定する
    /// - Parameters:
    ///   - RSSI: 最大RSSIのビーコンのRSSI
    ///   - threshold : 閾値（RSSI）
    /// - Returns: 入力が正しければtrue，正しくなければfalse
    func isOnNavigationPoint(RSSI : Int, threshold : Int) -> Bool {
        var flag: Bool = false
        //使用するUUIDと一致しており、かつ閾値よりも大きいRSSI
        if(RSSI > threshold){
            flag = true
        }
        return flag
    }
    
    //入力したminorが、ゴールのidと同じかを判定する
    func isGoal(minor_id : Int) -> Bool{
        return (minor_id == self.navigations!.goal_minor_id)
    }
    
    //入力したminorが、ルート上に存在するかを判定する
    func isAvailableBeacon(uuid : String, minor_id : Int) -> Bool{
        return self.navigations!.isAvailableBeaconId(uuid : uuid, id: minor_id)
    }
    
    //入力したminorに該当するナビゲーション情報を返す
    func getNavigationText(minor_id : Int) -> String{
        return self.navigations!.getNavigationText(id: minor_id)
    }


}
