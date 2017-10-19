//
//  LostDetectService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/10/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

enum LOST_DETECT_STATE{
    case IDLE
    case CHECK
}

class LostDetectService{
    //検知処理の状態
    var state = LOST_DETECT_STATE.IDLE
    
    //歩数計測用サービス
    var pedometerService = PedometerService()
    
    /// 迷っていることを検知する処理
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーション情報
    ///   - currentRouteId: 現在のroute id
    ///   - statemachineState: ステートマシンの状態コード
    ///   - receivedBeaconRssiList: 受信しているビーコンのRSSIリスト
    /// - Returns: チェックの結果(0:待機状態, 1:検出中, 2:迷ってるかも)
    func checkLost(navigations : NavigationEntity, currentRouteId: Int, statemachineState : Int, receivedBeaconRssiList : Dictionary<Int, Int>) -> Int{
        var retval = 0
        
        if(state == LOST_DETECT_STATE.IDLE){ //待機状態
            //現在のroute idが通路の場合、道から外れていないか確認を始める
            if(navigations.isRoad(routeId: currentRouteId)){
                state = LOST_DETECT_STATE.CHECK
                //検出を始める
                startLostDetect()
                retval = 1
            }
        }else if(state == LOST_DETECT_STATE.CHECK){ //検出中状態
            //通路から出た場合は、アイドリング状態に戻る
            if(navigations.isRoad(routeId: currentRouteId) == false){
                retval = 0
                state = LOST_DETECT_STATE.IDLE
                destroyLostDetect()
            }else{
                //期待する歩数の取得
                let expectedHosuu = navigations.getSteps(route_id: currentRouteId)
                //現在の歩数が予定よりも大幅に上回っている場合、アラートを通知
                if(pedometerService.get_steps() > expectedHosuu + 10){
                    retval = 2
                    state = LOST_DETECT_STATE.CHECK
                }else{
                    retval = 1
                }
            }
        }
        
        return retval
    }
    
    //検出が開始された時に呼ばれる関数
    func startLostDetect(){
        //歩数計測を開始する
        pedometerService.start_pedometer()
    }
    
    //検出を終了する時に呼ばれる関数
    func destroyLostDetect(){
        //歩数計測を終了する
        pedometerService.stop_pedometer()
    }
}
