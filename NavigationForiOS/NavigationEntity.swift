//
//  NavigationEntity.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/23.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

//交差点・目的地でのポイント情報
struct NavigationPoint{
    let minor_id : Int!  //minor_id
    let threshold : Int! //閾値
    let navigation_text : String! //読み上げるナビゲーション
    let type : Int! //1:目的地 2:交差点
}

class NavigationEntity{
    var routes = [NavigationPoint]() //ルート情報
    var bAvailable = false //ルート情報が有効かどうか
    var start_minor_id : Int!
    var goal_minor_id : Int!
    
    //ルート上のポイントを追加する
    // minor_id : ビーコンのminor threshold : 閾値
    func addPoint(minor_id : Int, threshold : Int, navigation_text : String, type: Int){
        routes.append(NavigationPoint(minor_id: minor_id, threshold: threshold, navigation_text: navigation_text, type: type))
    }
    
    //スタートとゴールが正しいか確認し、セットする
    func checkRoutes(start_id : Int, goal_id : Int) -> Bool{
        if(routes.first?.minor_id == start_id && routes.last?.minor_id == goal_id){
            start_minor_id = start_id
            goal_minor_id = goal_id
            bAvailable = true
            return true
        }else{
            return false
        }
    }
    
    //ルート上に存在するビーコンかを判定する
    func isAbailableId(id : Int) -> Bool{
        let retval = routes.filter({ $0.minor_id == id}).first
        if(retval != nil){
            return true
        }else{
            return false
        }
    }
    
    //指定したminorのナビゲーション内容を返す
    func getNavigationText(id : Int) -> String{
        let retval = routes.filter({ $0.minor_id == id}).first
        return (retval?.navigation_text)!
    }
}
