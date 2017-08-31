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
    
    //初期状態を設定
    var state: State = GoFoward()
    
    init(beaconService: BeaconService) {
        self.beaconservice = beaconService
    }
        
    /// ナビゲーション情報をサーバからJSON形式で取得
    ///
    /// - Returns: NavigationEntity
    func getNavigationData(responseNavigations: @escaping (NavigationEntity) -> Void){
        let navigation_entity = NavigationEntity()
        let requestUrl = "https://gist.githubusercontent.com/Minajun/f59deb00034b21342ff79c26d3658fff/raw/466b1a69f49b2df30240a3f122dc003a8b20ddd0/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["routes"].forEach{(_, data) in
                    let minor = data["minor"].int!
                    let threshold = data["threshold"].int!
                    let navigation = data["navigation"].string!
                    let type = data["type"].int!
                    //ナビゲーション情報を順番に格納
                    navigation_entity.addNavigationPoint(minor_id: minor, threshold: threshold, navigation_text: navigation, type: type)
                }
                //スタートとゴールのidを設定
                let start_minor_id = navJson["start"].int!
                let goal_minor_id = navJson["goal"].int!
                let retval = navigation_entity.checkRoutes(start_id: start_minor_id, goal_id: goal_minor_id)
                if(retval == false){
                    SlackService.postError(error: "有効でないルート情報", tag: "Nagivation Service")
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
        state.updateNavigation(navigationService: self, navigations: navigations, available: retval.available, maxRssiBeacon: maxRssiBeacon)
        //ナビゲーションテキストの取得
        navigation_text = state.getNavigation(navigations: navigations, maxRssiBeacon: maxRssiBeacon)
        //モードの取得
        mode = state.getMode()
        
        return (mode, maxRssiBeacon, navigation_text)
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

protocol State {
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity)
    func getMode() -> Int
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String
    
}

//ビーコン受信不能状態
class None: State{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "None"
    }

    func getMode() -> Int {
        return -1
    }

    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //受信できた場合、前進状態へ遷移
        if(available == true){
            navigationService.state = GoFoward()
        }
    }

    
}

//前進状態
class GoFoward: State{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "進もう"
    }

    func getMode() -> Int {
        return 1
    }

    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //ビーコンが受信できてない場合は、ビーコン受信不能状態へ
        if(available == false){
            navigationService.state = None()
            return
        }
        //RSSI最大のビーコンの閾値を取得し、ナビゲーションポイントに到達したかを判定する
        let threshold = navigations.getBeaconThreshold(minor_id: maxRssiBeacon.minorId)
        if(navigationService.isOnNavigationPoint(RSSI: maxRssiBeacon.rssi, threshold: threshold)){
            //ゴールに到着したかを判定
            if(maxRssiBeacon.minorId == navigations.goal_minor_id){
                //到着したとき、Goal状態へ遷移
                navigationService.state = Goal()
                return
            }
            //交差点到達状態へ遷移
            navigationService.state = OnThePoint()
        }
    }
    
}

//交差点到達状態
class OnThePoint: State{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return navigations.getNavigationText(minor_id: maxRssiBeacon.minorId)
    }

    func getMode() -> Int {
        return 1
    }

    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //RSSI最大のビーコンの閾値を取得し、ナビゲーションポイントに到達したかを判定する
        //本当は、右に曲がったか左に曲がったかで判断する
        let threshold = navigations.getBeaconThreshold(minor_id: maxRssiBeacon.minorId)
        if(navigationService.isOnNavigationPoint(RSSI: maxRssiBeacon.rssi, threshold: threshold)){
            //ゴールに到着したかを判定
            if(maxRssiBeacon.minorId == navigations.goal_minor_id){
                //到着したとき、Goal状態へ遷移
                navigationService.state = Goal()
                return
            }
        }else{
            //閾値を下回った場合、前進状態へ遷移
            navigationService.state = GoFoward()
        }
    }
    
}
/*

//右左折待機状態
class WaitTurn: State{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "待機中"
    }

    func getMode() -> Int {
        return 1
    }

    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {

    }
    
    
}
 
*/

//目的地到達状態
class Goal: State{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "Goal"
    }

    func getMode() -> Int {
        return 2
    }

    //呼ばれない関数
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        
    }
    
}
