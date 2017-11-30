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
    //初期値のroute id
    var initRouteId = 1
    
    //ステートマシンの状態
    var currentRouteId = 1
    
    //初期状態を設定
    var navigationState: NavigationState
    
    var state = "None"
    
    // DI
    var algorithm: AlgorithmBase!       // 適用アルゴリズム
    var beaconManager : BeaconManager!
    
    //音声用
    let speechService = SpeechService()
    
    init(beaconManager: BeaconManager, algorithm: AlgorithmBase) {
        navigationState = None(currentRouteId: initRouteId)
        self.beaconManager = beaconManager
        self.algorithm = algorithm
    }
    
    //地磁気用
    let magneticSensorService = MagneticSensorSerivce()
        
    /// 指定されたイベントのdepartureからdestinationのナビゲーション情報を取得する．
    ///
    /// - Returns: NavigationEntity
    func getNavigationData(eventId: String, departure: String, destination: String, responseNavigations: @escaping (NavigationEntity) -> Void){
        let navigation_entity = NavigationEntity()
        var requestUrl = "\(Const().URL_API)/routes/\(eventId)?departure=\(departure)&destination=\(destination)"
        requestUrl = requestUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                let route = navJson["data"]
                let status = navJson["status"].int!
                // ナビゲーション情報を取得できなかった場合．
                if status != 200 {
                    SlackService.postError(error: navJson["message"].string!, tag: "Nagivation Service")
                    break;
                }
                // ナビゲーション情報が取得できた場合は，レスポンスからナビゲーション情報を取得する
                route["routes"].forEach{(_, data) in
                    var beacons = [[BeaconRssi]]()
                    let routeId = data["areaId"].int!
                    let navigation = data["navigationText"].string!
                    let isStart = data["isStart"].int!
                    let isGoal = data["isGoal"].int!
                    let isCrossroad = data["isCrossroad"].int!
                    let isRoad = data["isRoad"].int!
                    let rotateDegree = data["rotateDegree"].int!
                    
                    // 各地点のビーコンをbeaconThresholdList配列に格納
                    let beaconsJSON = data["beacons"].array
                    // 教師データの取得（教師データの全体）
                    beaconsJSON?.forEach{(data) in
                        // ビーコンの数だけのminorIdとthresholdを配列に入れる．（教師データの１行）
                        var beaconRssiList: Array<BeaconRssi>! = []
                        data.forEach({ (_, beacon) in
                            let beaconRssi: BeaconRssi = BeaconRssi(minor_id: beacon["minorId"].int, rssi: beacon["rssi"].int)
                            beaconRssiList.append(beaconRssi)
                        })
                        beacons.append(beaconRssiList)
                    }
                    //ナビゲーション情報を順番に格納
                    navigation_entity.addNavigationPoint(route_id: routeId, navigation_text: navigation, expectedBeacons: beacons, isStart: isStart, isGoal: isGoal, isCrossroad: isCrossroad, isRoad: isRoad, rotate_degree: rotateDegree)
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navigation_entity)
        }
    }
    
    //NavigationServiceの初期化処理
    func initNavigation(navigations: NavigationEntity) {
        //ビーコンマネージャにナビゲーション情報を設定
        self.beaconManager.startBeaconReceiver(navigations: navigations)
        //地磁気センサの取得開始
        self.magneticSensorService.startMagneticSensorService()
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation(navigations: NavigationEntity) -> (mode : Int, navigation_text : String, navigation_state: String, expected_routeId: Int){
        var navigation_text : String!
        var mode = 1
        let receivedBeaconsRssi = beaconManager.getReceivedBeaconsRssi()
        
        //ナビゲーション情報の更新
        navigationState.updateNavigation(navigationService: self, navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, algorithm: algorithm)
        
        //モードの取得
        mode = navigationState.getMode(navigations: navigations)
        
        //ステートマシンの状態を取得
        let navigationStateMachineProperty = navigationState.getNavigationState()
        
        //ナビゲーションテキストの設定
        //交差点のときは，向く角度からテキストを生成する
        if(navigationStateMachineProperty.state == "Crossroad"){
            //モードの中に向く角度が入っている
            //1: 直進 2: 左折 3: 右折
            switch mode{
            case 2:
                navigation_text = "左折です"
            case 3:
                navigation_text = "右折です"
            default:
                navigation_text = "直進です"
            }
        }else{
            navigation_text = navigationState.getNavigation(navigations: navigations)
        }
        
        //音声案内(ステートマシンの状態が遷移したら)
        if(navigationStateMachineProperty.currentRouteId != self.currentRouteId || navigationStateMachineProperty.state != state){
            announceWithSE(announceText: navigation_text)
            self.currentRouteId = navigationStateMachineProperty.currentRouteId
        }

        //ステートマシンの状態を更新
        state = navigationStateMachineProperty.state
        
        return (mode, navigation_text, navigationStateMachineProperty.state, navigationStateMachineProperty.currentRouteId)
    }
    
    //現在いる場所のroute idを取得する
    func getCurrentRouteId(navigations: NavigationEntity) -> Int{
        return algorithm.getCurrentRouteId(navigations: navigations, receivedBeaconsRssi: beaconManager.getReceivedBeaconsRssi())
    }
    
    //効果音付きで案内をする
    func announceWithSE(announceText : String){
        speechService.announce(str: announceText)
    }
    
    //効果音なしで読み上げをする
    func speech(speechText: String){
        speechService.textToSpeech(str: speechText)
    }
    
    /// 現在の最大RSSIのビーコン情報を取得
    ///
    /// - Returns: ビーコン情報
    func getMaxRssiBeacon() -> BeaconEntity {
        return beaconManager.getMaxRssiBeacon().maxRssiBeacon
    }
    
    /// 地磁気方向の取得
    ///
    /// - Returns: 地磁気方向 N:0deg E:90deg S:180deg W:270deg
    func getMagneticOrientation() -> Double{
        return magneticSensorService.getMagneticDirection()
    }
}

