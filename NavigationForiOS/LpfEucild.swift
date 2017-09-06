//
//  LpfEucild.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class LpfEuclid: AlgorithmBase {
    func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> POINT {
        return POINT.OTHER
    }
    
    func getRouteId(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> Int {
        return 1;
    }
    
    /// 電波強度から、ビーコンまでの距離を計算する関数
    ///
    /// - Parameter rssi: ビーコンの電波強度（dB）
    /// - Returns: ビーコンまでの距離 (m)
    func getBeaconDist(rssi: Int) -> Double{
        let TxPower = -75.0 //ビーコンから1mの距離で観測される電波強度
        return pow(10.0, (TxPower - Double(rssi)) / 20.0)
    }
}
