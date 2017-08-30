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
    func updateNavigation(navigations: NavigationEntity) -> (mode : Int, minor_id : Int, rssi : Int, navigation_text : String){
        var minor_id : Int!
        var rssi : Int!
        var navigation_text : String!
        var mode = 1
        
        //現在の最大RSSIのビーコン情報を取得
        let retval = beaconservice.getMaxRssiBeacon()
        
        //存在するビーコンか判定する
        minor_id = retval.minor
        rssi = retval.rssi
        navigation_text = ""
        if(retval.available == true){
            //ナビゲーションの更新
            //RSSI最大のビーコンの閾値を取得し、ナビゲーションポイントに到達したかを判定する
            let threshold = navigations.getBeaconThreshold(minor_id: minor_id)
            if(isOnNavigationPoint(RSSI: retval.rssi, threshold: threshold)){
                //ゴールに到着したかを判定
                if(retval.minor == navigations.goal_minor_id){
                    //到着した
                    navigation_text = "Goal"
                    mode = 2
                }else{
                    //到達してない
                    navigation_text = navigations.getNavigationText(minor_id: retval.minor)
                }
            }else{
                navigation_text = "進もう"
            }
        }else{
            mode = -1
        }
        return (mode, minor_id, rssi, navigation_text)
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
