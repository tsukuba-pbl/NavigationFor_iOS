//
//  LostDetectService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/10/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class LostDetectService{
    //歩数計測用サービス
    let pedometerService = PedometerService()
    
    
    /// 迷っていることを検知する処理
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーション情報
    ///   - currentRouteId: 現在のroute id
    ///   - statemachineState: ステートマシンの状態コード
    ///   - receivedBeaconRssiList: 受信しているビーコンのRSSIリスト
    /// - Returns: チェックの結果
    func checkLost(navigations : NavigationEntity, currentRouteId: Int, statemachineState : Int, receivedBeaconRssiList : Dictionary<Int, Int>) -> Int{
        var retval = 0
        
        return retval
    }
}
