//
//  KNN.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/11.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//
import Foundation

struct knnData{
    var X: [Double]
    var routeId: Int
}

struct EuclidData {
    var routeId: Int
    var euclidResult: Double
}

enum POINT {
    case GOAL
    case START
    case ON_POINT
    case OTHER
}

class KNN: AlgorithmBase{
    
    /// k近傍で指定目的地に到達したかどうかを判定し、その結果を返す
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーションのルートなどの情報を含む変数
    ///   - receivedBeaconsRssi: 現在のビーコンのRSSIの値（平滑化済み）
    ///   - expectedRouteId: 到達するか判定する場所のroute id
    /// - Returns: return 現在の場所のENUM
    override func isOnPoint(navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, expectedRouteId: Int) -> POINT {
        var status: POINT
        
        //交差点にいるかいないかをk近傍で判定する
        //トレーニングデータを作成
        var trainData = [knnData]()
        
        navigations.routes.forEach { (navigationPoint) in
            //種別を取得
            var routeId : Int!
            if(navigationPoint.route_id == expectedRouteId){
                routeId = 1
            }else{
                routeId = 0
            }
            //対応するroute idのトレーニングデータを取得
            let routeTrainData = navigations.getRouteExpectedBeacons(route_id: navigationPoint.route_id)
            routeTrainData.forEach { (routeTrainDataList) in
                var logData = [Double]()
                routeTrainDataList.forEach{ (routeTrainData) in
                    logData.append(Double(routeTrainData.rssi))
                }
                trainData.append(knnData(X: logData, routeId: routeId))
            }
        }
        
        //入力データの作成(現在取得しているビーコン)
        var beaconRssiData = [Double]()
        let expectedTrainData = navigations.getRouteExpectedBeacons(route_id: expectedRouteId)
        expectedTrainData.first?.forEach({ (beacon) in
            beaconRssiData.append(Double(receivedBeaconsRssi[beacon.minor_id]!))
        })
        let inputData = knnData(X: beaconRssiData, routeId: 1)
        
        //k近傍によって判定
        //return 1:いる 0:いない
        let ans = knn(trainData: trainData, inputData: inputData)
        
        if(ans == 1){
            //目的地に到達したか判定
            if(expectedRouteId == navigations.getGoalRouteId()){
                status = POINT.GOAL
            }else{
                status = POINT.ON_POINT
            }
        }else{
            status = POINT.OTHER
        }
        
        return status
    }
    
    override func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> Int {
        //交差点にいるかいないかをk近傍で判定する
        //トレーニングデータを作成
        var trainData = [knnData]()
        
        navigations.routes.forEach { (navigationPoint) in
            //対応するroute idのトレーニングデータを取得
            let routeTrainData = navigations.getRouteExpectedBeacons(route_id: navigationPoint.route_id)
            routeTrainData.forEach { (routeTrainDataList) in
                var logData = [Double]()
                routeTrainDataList.forEach{ (routeTrainData) in
                    logData.append(Double(routeTrainData.rssi))
                }
                trainData.append(knnData(X: logData, routeId: navigationPoint.route_id))
            }
        }
        
        //入力データの作成(現在取得しているビーコン)
        var beaconRssiData = [Double]()
        let expectedTrainData = navigations.getRouteExpectedBeacons(route_id: 1)
        expectedTrainData.first?.forEach({ (beacon) in
            beaconRssiData.append(Double(receivedBeaconsRssi[beacon.minor_id]!))
        })
        let inputData = knnData(X: beaconRssiData, routeId: 1)
        
        //k近傍によって判定
        //return 1:いる 0:いない
        let ans = knn(trainData: trainData, inputData: inputData)
        
        return ans
    }
    
    /// k近傍法
    ///
    /// - Parameters:
    ///   - trainData: 教師データ
    ///   - inputData: 入力データ
    /// - Returns: クラスid 取れない時は-1
    func knn(trainData: [knnData], inputData: knnData) -> Int{
        var dist = [EuclidData]()
        //ユークリッド距離を求める
        for i in trainData{
            dist.append(EuclidData(routeId: i.routeId, euclidResult: getEuclidDist(trainData: i, inputData: inputData)))
        }
        //距離が短い順にソーティング
        let sortedDist: [EuclidData] = dist.sorted(){ $0.euclidResult < $1.euclidResult }
        //上位3つのデータを取得する
        let target = sortedDist[0...2]
        
        //上位3つのデータで多数決を取る
        var targetTop3 = Dictionary<Int, Int>()
        for i in target {
            if ((targetTop3[i.routeId]) != nil) {
                targetTop3[i.routeId] = targetTop3[i.routeId]! + 1
            } else {
                targetTop3[i.routeId] = 1
            }
        }
        
        //最も多いデータを返す
        let result = targetTop3.sorted { $0.1 > $1.1 }
        return (result.first?.key)!
    }
    
    /// ユークリッド距離を求める関数
    ///
    /// - Parameters:
    ///   - trainData: 教師データ
    ///   - inputData: 入力データ
    /// - Returns: ユークリッド距離
    func getEuclidDist(trainData: knnData, inputData: knnData) -> Double{
        var result: Double = 0.0
        
        for (i,value) in trainData.X.enumerated(){
            result += pow(Double(inputData.X[i] - value), 2)
        }
        result = sqrt(result)
        
        return result
    }
    
    /// k近傍の教師データに対する精度を返す
    ///
    /// - Parameter trainData: 教師データ
    /// - Returns: 精度
    func getKnnAccuracy(trainData: [knnData]) -> Double{
        var nCorrect = 0   //正答数をカウント
        var accuracy = 0.0
        
        for (i,inputData) in trainData.enumerated(){
            //入力する教師データを教師データ群から削除する
            var targetTrainData = [knnData]()
            for(j,element2) in trainData.enumerated(){
                if(i != j){
                    targetTrainData.append(element2)
                }
            }
            let answer = knn(trainData: targetTrainData, inputData: inputData)
            if(answer == inputData.routeId){
                nCorrect += 1
            }
        }
        
        accuracy = Double(nCorrect) / Double(trainData.count)
        
        return accuracy
    }
}
