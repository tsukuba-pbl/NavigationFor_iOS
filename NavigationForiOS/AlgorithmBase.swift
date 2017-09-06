//
//  AlgorithmBase.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/06.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class AlgorithmBase: AlgorithmBaseProtocol {
    
    func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, expectedBeaconsRssi: Dictionary<Int, Int>) -> POINT {
        return POINT.OTHER
    }
    
    /// 最大値のRSSIを取得する関数
    ///
    /// - Parameter receivedBeaconsRssi: 現在のビーコンのRSSIの値（平滑化済み）
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
}
