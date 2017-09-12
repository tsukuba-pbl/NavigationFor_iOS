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
    let isStart: Int!
    let isGoal: Int!
    let isCrossroad: Int!
    let isRoad: Int!
    let expectedBeacons : [[BeaconRssi]] //事前計測データ
}

//ビーコンの事前計測電波強度
struct BeaconRssi{
    let minor_id: Int! //minor id
    let rssi: Int! //閾値
}

class NavigationEntity{
    var routes = [NavigationPoint]() //ルート情報
    var isAvailable = false //ルート情報が有効かどうか
    var start_id : Int!
    var goal_id : Int!
    
    let UUIDList = [
        "12345678-1234-1234-1234-123456789ABC"
    ]
    
    //ルート上のポイントを追加する
    // minor_id : ビーコンのminor threshold : 閾値
    func addNavigationPoint(route_id: Int, navigation_text : String, expectedBeacons: [[BeaconRssi]], isStart: Int, isGoal: Int, isCrossroad: Int, isRoad: Int){
        routes.append(NavigationPoint(route_id: route_id, navigation_text: navigation_text, isStart: isStart, isGoal: isGoal, isCrossroad: isCrossroad, isRoad: isRoad, expectedBeacons: expectedBeacons))
    }
    
    //スタートのIDを取得する
    func getStartRouteId() -> Int{
        return (routes.first?.route_id)!
    }
    
    //ゴールのIDを取得する
    func getGoalRouteId() -> Int{
        return (routes.last?.route_id)!
    }
    
    //指定したroute idのナビゲーション内容を返す
    func getNavigationText(route_id : Int) -> String{
        let navigationTextByRouteId = routes.filter({ $0.route_id == route_id}).first
        return (navigationTextByRouteId?.navigation_text)!
    }
    
    //指定したroute idの閾値の集合を返す
    func getRouteExpectedBeacons(route_id : Int) -> [[BeaconRssi]]{
        let beaconThresholdFilteredByRouteId = routes.filter({ $0.route_id == route_id}).first
        return (beaconThresholdFilteredByRouteId?.expectedBeacons)!
    }
    
    //指定したminor idが属するroute idを返す
    //ない場合は-1がリターンされる
//    func getRouteIdFromMinorId(minor_id: Int) -> Int{
//        var retval = -1
//        for i in routes{
//            if(i.expectedBeacons.filter({$0.minor_id == minor_id}).first != nil){
//                retval = i.route_id
//                break
//            }
//        }
//        return retval
//    }
    
    //指定したminor idのビーコンの閾値を返す
    //ない場合は-100がリターンされる
    //*** あとで、ルートidも指定して絞る必要あり ***
//    func getBeaconThresholdFromMinorId(minor_id: Int) -> Int{
//        var retval = -100
//        for i in routes{
//            let retval2 = i.expectedBeacons.filter({$0.minor_id == minor_id}).first
//            if(retval2 != nil){
//                retval = (retval2?.threshold)!
//                break
//            }
//        }
//        return retval
//    }
    
    //使用するビーコンのUUIDリストを返す
    func getUUIDList() -> Array<String>{
        return UUIDList
    }
    
    //使用するビーコンのminor idのリストを返す
    func getMinorList() -> Array<Int>{
        var minorIdList = [Int]()
        routes.first?.expectedBeacons.first?.forEach{ (beacon) in
            minorIdList.append(beacon.minor_id)
        }
        return minorIdList
    }
}
