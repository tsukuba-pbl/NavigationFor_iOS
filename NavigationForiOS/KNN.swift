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

class KNN: AlgorithmBase{
    
    /// k近傍で現在いる場所を取得する関数
    ///
    /// - Parameters:
    ///   - navigations: ナビゲーションのルートなどの情報を含む変数
    ///   - receivedBeaconsRssi: 現在のビーコンのRSSIの値（平滑化済み）
    /// - Returns: return 現在の場所のENUM
    override func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>) -> POINT {
        //教師データの作成
        
        
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
            dist.append(EuclidData(routeId: i.routeId, euclidResult: EuclidDist(trainData: i, inputData: inputData)))
        }
        //距離が短い順にソーティング
        var sortedDist: [EuclidData] = dist.sorted(){ $0.euclidResult < $1.euclidResult }
        var target = [EuclidData]()
        
        for (i, value) in sortedDist.enumerated() {
            if (i < 3) {
                target.append(value)
            } else {
                break
            }
        }
        
        //上位3つのデータ多数決を取る
        var result = Dictionary<Int, Int>()
        for i in target {
            if ((result[i.routeId]) != nil) {
                result[i.routeId] = result[i.routeId]! + 1
            } else {
                result[i.routeId] = 1
            }
        }
        let owari = result.sorted { $0.1 > $1.1 }
        return (owari.first?.key)!
    }
    
    
    /// ユークリッド距離を求める関数
    ///
    /// - Parameters:
    ///   - trainData: 教師データ
    ///   - inputData: 入力データ
    /// - Returns: ユークリッド距離
    func EuclidDist(trainData: knnData, inputData: knnData) -> Double{
        var result: Double = 0.0
        
        for (i,value) in trainData.X.enumerated(){
            result += pow(Double(inputData.X[i] - value), 2)
        }
        
        return round(sqrt(result)*100)/100
    }
}
