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
    var beaconservice : BeaconService!
    var algorithm: AlgorithmBase = NavigationAlgorithmFactory.getNavigationAlgorithm(type: ALGORITHM_TYPE.LPF)
    //初期状態を設定
    var navigationState: NavigationState = GoFoward()
    
    init(beaconService: BeaconService) {
        self.beaconservice = beaconService
    }
        
    /// ナビゲーvarョン情報をサーバからJSON形式で取得
    ///
    /// - Returns: NavigationEntity
    func getNavigationData(responseNavigations: @escaping (NavigationEntity) -> Void){
        let navigation_entity = NavigationEntity()
        let requestUrl = "https://gist.githubusercontent.com/ferretdayo/9ae8f4fda61dfea5e0ddf38b1783460a/raw/46b6dfe606731ff91902a7aac48e55f64a5908ff/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                var beaconThresholdList: Array<BeaconThreshold>! = []
                navJson["routes"].forEach{(_, data) in
                    let routeId = data["routeId"].int!
                    let navigation = data["navigation"].string!
                    
                    // 各地点のビーコンをbeaconThresholdList配列に格納
                    let beaconsJSON = data["beacons"].array
                    beaconsJSON?.forEach{(data) in
                        let beaconThreshold: BeaconThreshold = BeaconThreshold(minor_id: data["minorId"].int, threshold: data["threshold"].int)
                        beaconThresholdList.append(beaconThreshold)
                    }
                    //ナビゲーション情報を順番に格納
                    navigation_entity.addNavigationPoint(route_id: routeId, navigation_text: navigation, expectedBeacons: beaconThresholdList)
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navigation_entity)
        }
    }
    
    func initNavigation(navigations: NavigationEntity) {
        self.beaconservice.startBeaconReceiver(navigations: navigations)
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation(navigations: NavigationEntity) -> (mode : Int, maxRssiBeacon: BeaconEntity, navigation_text : String){
        var maxRssiBeacon: BeaconEntity!
        var navigation_text : String!
        var mode = 1
        
        //現在の最大RSSIのビーコン情報を取得
        let retval = beaconservice.getMaxRssiBeacon()
        maxRssiBeacon = retval.maxRssiBeacon
        
        //ナビゲーション情報の更新
        navigationState.updateNavigation(navigationService: self, navigations: navigations, receivedBeaconsRssi: beaconservice.getReceivedBeaconsRssi(), algorithm: algorithm)
        //ナビゲーションテキストの取得
        navigation_text = navigationState.getNavigation(navigations: navigations, maxRssiBeacon: maxRssiBeacon)
        //モードの取得
        mode = navigationState.getMode()
        
        return (mode, maxRssiBeacon, navigation_text)
    }
}

