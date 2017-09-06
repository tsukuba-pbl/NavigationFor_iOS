//
//  LpfEucild.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class LpfEuclid: AlgorithmBase {
    
    /// 現在いる場所を取得する関数
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーションのルートなどの情報を含む変数
    ///   - receivedBeaconsRssi: 現在のビーコンのRSSIの値（平滑化済み）
    /// - Returns: return 現在の場所のENUM
    override func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> POINT {
        
        return POINT.OTHER
    }
    
    /// 電波強度から、ビーコンまでの距離を計算する関数
    ///
    /// - Parameter rssi: ビーコンの電波強度（dB）
    /// - Returns: ビーコンまでの距離 (m)
    func getBeaconDist(rssi: Int) -> Double{
        let TxPower = -75.0 //ビーコンから1mの距離で観測される電波強度
        return pow(10.0, (TxPower - Double(rssi)) / 20.0)
    }
    
    
    /// ユークリッド距離の算出
    ///
    /// - Parameters:
    ///   - receivedBeaconRssiList: 現在のビーコンのRSSIの値（平滑化済み）
    ///   - expectedBeaconRssiList: 予期しているビーコンのRSSIの値
    /// - Returns: ユークリッド距離
    func getEuclidResult(receivedBeaconRssiList: Dictionary<Int, Int>, expectedBeaconRssiList: Dictionary<Int, Int>) -> Double {
        var result: Double = 0.0
        receivedBeaconRssiList.forEach { (key: Int, value: Int) in
            result += pow(Double(value - expectedBeaconRssiList[key]!), 2)
        }
        return round(sqrt(result)*100)/100
    }
}
