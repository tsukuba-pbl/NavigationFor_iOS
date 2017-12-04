//
//  KotonaviEntity.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/12/01.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class KotonaviEntity{
    private var navigations: NavigationEntity
    private var kotonaviText = ""
    private var destination = ""
    private var departure = ""
    
    init(navigations: NavigationEntity, departure: String, destination: String){
        //ナビゲーション情報を格納
        self.navigations = navigations
        self.departure = departure
        self.destination = destination
        //ことなびを生成
        generateKotonabiText(navigations: navigations)
    }
    
    //ことナビを生成する
    private func generateKotonabiText(navigations: NavigationEntity){
        kotonaviText += departure + "から" + destination + "までの案内を行います。"
        var kotonaviText2 = ""
        var sumDistance = 0
        //ルート情報を取得する
        var count = 1
        for (index, element) in navigations.routes.enumerated(){
            //ゴールの時は強制終了
            if(element.isGoal == 1){
                break
            }
            if(element.isCrossroad == 1){
                let distance = Int(Double(navigations.routes[index+1].expectedBeacons.count) * 0.78)
                sumDistance += distance
                if(navigations.routes[index+2].isGoal == 0){
                    let turnText = navigations.routes[index+2].rotate_degree > 0 ? "左折" : "右折"
                    kotonaviText2 += "\(count)番目の交差点まで，およそ\(distance)メートル進み，" + turnText + "します。"
                }else{
                    kotonaviText2 += "最後に" + self.destination + "まで，およそ\(distance)メートル進みます。"
                }
                count += 1
            }
        }
        if(count == 1){
            kotonaviText += "交差点は全部で\(count - 1)箇所あります。"
        }else{
            kotonaviText += "交差点はありません。"
        }
        kotonaviText += "目的地までおよそ\(sumDistance)メートルです。"
        kotonaviText += kotonaviText2
    }
    
    public func getKotonaviText() -> String{
        return kotonaviText
    }
}
