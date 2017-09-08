//
//  BeaconLoggerController.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/08.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class BeaconLoggerController{
    var navigations : NavigationEntity = NavigationEntity()
    var beaconManager : BeaconManager = BeaconManager()
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - navigations: 使用するビーコン情報の入ったナビゲーション情報
    init(navigations: NavigationEntity){
        //使用するビーコン情報を格納
        self.navigations = navigations
        //受信するビーコンの情報を与え、受信を開始する
        beaconManager.startBeaconReceiver(navigations: self.navigations)
    }
}
