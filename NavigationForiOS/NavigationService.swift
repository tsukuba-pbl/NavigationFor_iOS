//
//  NavigationService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NavigationService {
    //初期状態を設定
    var navigationState: NavigationState = None()
    
    // DI
    var algorithm: AlgorithmBase!       // 適用アルゴリズム
    var beaconManager : BeaconManager!
    
    init(beaconManager: BeaconManager, algorithm: AlgorithmBase) {
        self.beaconManager = beaconManager
        self.algorithm = algorithm
    }
        
    /// ナビゲーvarョン情報をサーバからJSON形式で取得
    ///
    /// - Returns: NavigationEntity
    func getNavigationData(responseNavigations: @escaping (NavigationEntity) -> Void){
        let navigation_entity = NavigationEntity()
        let requestUrl = "https://gist.githubusercontent.com/ferretdayo/9ae8f4fda61dfea5e0ddf38b1783460a/raw/c94288bb89dbc9e6b76173aee59ffe2ff778fb56/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["routes"].forEach{(_, data) in
                    var beacons: [[BeaconThreshold]] = [[]]
                    let routeId = data["routeId"].int!
                    let navigation = data["navigation"].string!
                    let isStart = data["isStart"].int!
                    let isGoal = data["isGoal"].int!
                    let isCrossroad = data["isCrossroad"].int!
                    let isRoad = data["isRoad"].int!
                    
                    // 各地点のビーコンをbeaconThresholdList配列に格納
                    let beaconsJSON = data["beacons"].array
                    // 教師データの取得（教師データの全体）
                    beaconsJSON?.forEach{(data) in
                        // ビーコンの数だけのminorIdとthresholdを配列に入れる．（教師データの１行）
                        var beaconThresholdList: Array<BeaconThreshold>! = []
                        data.forEach({ (beacon) in
                            let beaconThreshold: BeaconThreshold = BeaconThreshold(minor_id: data["minorId"].int, threshold: data["threshold"].int)
                            beaconThresholdList.append(beaconThreshold)
                        })
                        beacons.append(beaconThresholdList)
                    }
                    //ナビゲーション情報を順番に格納
                    navigation_entity.addNavigationPoint(route_id: routeId, navigation_text: navigation, isStart: isStart, isGoal: isGoal, isCrossroad: isCrossroad, isRoad: isRoad, expectedBeacons: beaconThresholdList)
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navigation_entity)
        }
    }
    
    func initNavigation(navigations: NavigationEntity) {
        self.beaconManager.startBeaconReceiver(navigations: navigations)
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation(navigations: NavigationEntity) -> (mode : Int, navigation_text : String){
        var navigation_text : String!
        var mode = 1
        let receivedBeaconsRssi = beaconManager.getReceivedBeaconsRssi()
        
        //ナビゲーション情報の更新
        navigationState.updateNavigation(navigationService: self, navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, algorithm: algorithm)
        
        //ナビゲーションテキストの取得
        let routeId = algorithm.getRouteId(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi)
        navigation_text = navigationState.getNavigation(navigations: navigations, routeId: routeId)
        //モードの取得
        mode = navigationState.getMode()
        
        return (mode, navigation_text)
    }
    
    
    /// 現在の最大RSSIのビーコン情報を取得
    ///
    /// - Returns: ビーコン情報
    func getMaxRssiBeacon() -> BeaconEntity {
        return beaconManager.getMaxRssiBeacon().maxRssiBeacon
    }
}

