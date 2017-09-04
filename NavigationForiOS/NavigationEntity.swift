//
//  NavigationEntity.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/23.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//
import Foundation

//交差点・目的地でのポイント情報
struct NavigationPoint{
    let route_id: Int!
    let navigation_text : String! //読み上げるナビゲーション
    let expectedBeacons : Array<BeaconThreshold> //事前計測データ
}

//ビーコンの事前計測電波強度
struct BeaconThreshold{
    let minor_id: Int! //minor id
    let threshold: Int! //閾値
}

class NavigationEntity{
    var routes = [NavigationPoint]() //ルート情報
    var isAvailable = false //ルート情報が有効かどうか
    var start_id : Int!
    var goal_id : Int!
    
    let UUIDList = [
        "12345678-1234-1234-1234-123456789ABC"
    ]
    var MinorIdList = [Int]()
    
    //ルート上のポイントを追加する
    // minor_id : ビーコンのminor threshold : 閾値
    func addNavigationPoint(route_id: Int, navigation_text : String, expectedBeacons: [BeaconThreshold]){
        routes.append(NavigationPoint(route_id: route_id, navigation_text: navigation_text, expectedBeacons: expectedBeacons))
        //使用しているminor idを登録
        for i in expectedBeacons{
            if(MinorIdList.contains(i.minor_id)){
                MinorIdList.append(i.minor_id)
            }
        }
    }
    
    //スタートのIDを取得する
    func getStartRouteId() -> Int{
        return (routes.first?.route_id)!
    }
    
    //ゴールのIDを取得する
    func getGoalRouteId() -> Int{
        return (routes.last?.route_id)!
    }
    
    //ルート上に存在するビーコンかを判定する
    //システムで使用しているビーコンかどうかを判定する
    func isAvailableBeaconId(uuid : String, minor_id : Int) -> Bool{
        var available = false
        if(MinorIdList.contains(minor_id) && UUIDList.contains(uuid)){
            available = true
        }else{
            available = false
        }
        return available
    }
    
    //指定したroute idのナビゲーション内容を返す
    func getNavigationText(route_id : Int) -> String{
        let retval = routes.filter({ $0.route_id == route_id}).first
        return (retval?.navigation_text)!
    }
    
    //指定したroute idの閾値の集合を返す
    func getBeaconThreshold(route_id : Int) -> Array<BeaconThreshold>{
        let retval = routes.filter({ $0.route_id == route_id}).first
        return (retval?.expectedBeacons)!
    }
    
    //使用するビーコンのUUIDリストを返す
    func getUUIDList() -> Array<String>{
        return UUIDList
    }
    
    //使用するビーコンのminor idのリストを返す
    func getMinorList() -> Array<Int>{
        return MinorIdList
    }
}
