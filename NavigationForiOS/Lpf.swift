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
    
    /// 現在いる場所を取得する関数
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーションのルートなどの情報を含む変数
    ///   - receivedBeaconsRssi: 実際に歩いて取得できたビーコンのRSSIの値（平滑化済み）
    /// - Returns: return 現在の場所のENUM
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
    
    
    /// 最大値のRSSIを取得する関数
    ///
    /// - Parameter receivedBeaconsRssi: ナビゲーションで利用しているビーコンのRssiの値(平滑化済み)
    /// - Returns: 最大のRSSIの値を持つminorId
    func getMaxRssiMinorId(receivedBeaconsRssi: Dictionary<Int, Int>) -> Int {
        var maxMinorId = -1
        var maxRssi = -1000
        receivedBeaconsRssi.forEach { (key: Int, value: Int) in
            if(maxRssi < value) {
                maxMinorId = key
                maxRssi = value
            }
        }
        return maxMinorId
    }
    
    
    /// 現在のルートIDを取得する関数
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーションのルートなどの情報を含む変数
    ///   - receivedBeaconsRssi: 実際に歩いて取得できたビーコンのRSSIの値（平滑化済み）
    /// - Returns: 現在のルートID
    func getRouteId(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> Int {
        var target = self.getMaxRssiMinorId(receivedBeaconsRssi: receivedBeaconsRssi)
        return navigations.getRouteIdFromMinorId(minor_id: target)
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
        if(RSSI > threshold && RSSI > -100){
            flag = true
        }
        return flag
    }
}
