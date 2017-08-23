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
    static let navigations = NavigationEntity() //ナビゲーション情報
    var beaconservice : BeaconService!
    var uuidList : Array<String> = []
    
    //イニシャライザ
    init(){
        //BeaconServiceのインスタンス生成
        beaconservice = BeaconService()
        
        //ナビゲーションデータの読み込み
        NavigationService.getNavigationData{response in
            
        }
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation() -> (mode : Int, minor_id : Int, uuid : String, rssi : Int, navigation_text : String){
        var minor_id : Int!
        var uuid : String!
        var rssi : Int!
        var navigation_text : String!
        var mode = 1
        
        //現在の最大RSSIのビーコン情報を取得
        let retval = beaconservice.getMaxRssiBeacon()
        
        //存在するビーコンか判定する
        minor_id = retval.minor
        uuid = retval.uuid
        rssi = retval.rssi
        navigation_text = ""
        if(retval.flag == true){
            //ナビゲーションの更新
            //RSSI最大のビーコンのRSSIの値が-80dB以下のとき、案内が表示されるようにする
            if(isOnNavigationPoint(RSSI: retval.rssi, uuid: UUID(uuidString : retval.uuid)!, threshold: -80)){
                //ゴールに到着したかを判定
                if(NavigationService.isGoal(minor_id: retval.minor)){
                    //到着した
                    navigation_text = "Goal"
                    mode = 2
                }else{
                    //到着してない　途中のとき
                    //ルート上のビーコンか判定
                    if(NavigationService.isAvailableBeacon(uuid: uuid, minor_id: minor_id)){
                        navigation_text = NavigationService.getNavigationText(minor_id: retval.minor)
                    }else{
                        navigation_text = "ルート上から外れている可能性があります"
                    }
                }
            }else{
                navigation_text = "進もう"
            }
        }
        return (mode, minor_id, uuid, rssi, navigation_text)
    }
    
    /// ナビゲーション情報をサーバからJSON形式で取得
    ///
    /// - Returns: minor値とナビゲーションを対応させたDictionary
    static func getNavigationData(responseNavigations: @escaping (Dictionary<Int,String>) -> Void){
        var navDic = [Int: String]() //minorとナビゲーション内容を対応させたDictionary
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
                    navDic[minor] = navigation
                    //ナビゲーション情報を順番に格納
                    navigations.addNavigationPoint(minor_id: minor, threshold: threshold, navigation_text: navigation, type: type)
                }
                //スタートとゴールのidを設定
                let start_minor_id = navJson["start"].int!
                let goal_minor_id = navJson["goal"].int!
                let retval = navigations.checkRoutes(start_id: start_minor_id, goal_id: goal_minor_id)
                if(retval == false){
                    SlackService.postError(error: "有効でないルート情報", tag: "Nagivation Service")
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navDic)
        }
    }
    
    //ナビゲーションを行うタイミングを判定する
    //目的地もしくは交差点にいるかを判定する
    /// - Parameters:
    ///   - RSSI: 最大RSSIのビーコンのRSSI
    ///   - uuid: 最大RSSIのビーコンのuuid
    ///   - threshold : 閾値（RSSI）
    /// - Returns: 入力が正しければtrue，正しくなければfalse
    func isOnNavigationPoint(RSSI : Int, uuid : UUID, threshold : Int) -> Bool {
        var flag: Bool = false
        //使用するUUIDと一致しており、かつ閾値よりも大きいRSSI
        if(uuidList.contains(uuid.uuidString) == true && RSSI > threshold){
            flag = true
        }
        return flag
    }
    
    //入力したminorが、ゴールのidと同じかを判定する
    static func isGoal(minor_id : Int) -> Bool{
        return (minor_id == navigations.goal_minor_id)
    }
    
    //入力したminorが、ルート上に存在するかを判定する
    static func isAvailableBeacon(uuid : String, minor_id : Int) -> Bool{
        return navigations.isAvailableBeaconId(uuid : uuid, id: minor_id)
    }
    
    //入力したminorに該当するナビゲーション情報を返す
    static func getNavigationText(minor_id : Int) -> String{
        return navigations.getNavigationText(id: minor_id)
    }

}
