//
//  LPF.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

enum POINT {
    case GOAL
    case START
    case CROSSROAD
    case OTHER
}

class Lpf: AlgorithmBase {
    func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>) -> POINT {
        let maxRssiMinorId = self.getMaxRssiMinorId(receivedBeaconsRssi: receivedBeaconsRssi)
        let threshold = navigations.getBeaconThresholdFromMinorId(minor_id: maxRssiMinorId)
        if(self.isOnNavigationPoint(RSSI: receivedBeaconsRssi[maxRssiMinorId]!, threshold: threshold)){
            //ゴールに到着したかを判定
            if(navigations.getRouteIdFromMinorId(minor_id: maxRssiMinorId) == navigations.getGoalRouteId()){
                return POINT.GOAL
            }
            //交差点到達状態へ遷移
            return POINT.CROSSROAD
        }
        return POINT.OTHER
    }
    
    func getMaxRssiMinorId(receivedBeaconsRssi: Dictionary<Int, Int>) -> Int {
        var maxMinorId = -1
        var maxRssi = -100
        receivedBeaconsRssi.forEach { (key: Int, value: Int) in
            if(maxRssi < value) {
                maxMinorId = key
                maxRssi = value
            }
        }
        return maxMinorId
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
}
