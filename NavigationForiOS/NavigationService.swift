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
    static let navigations = NavigationEntity()
    
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
                    //Dictionaryにペアとして追加（key:minor val:navigation）
                    let minor = data["minor"].int!
                    let threshold = data["threshold"].int!
                    let navigation = data["navigation"].string!
                    let type = data["type"].int!
                    navDic[minor] = navigation
                    //ナビゲーション情報を順番に格納
                    navigations.addPoint(minor_id: minor, threshold: threshold, navigation_text: navigation, type: type)
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
    
    //入力したminorが、ゴールのidと同じかを判定する
    static func isGoal(minor_id : Int) -> Bool{
        return (minor_id == navigations.goal_minor_id)
    }
    
    //入力したminorが、ルート上に存在するかを判定する
    static func isAvailableBeacon(minor_id : Int) -> Bool{
        return navigations.isAbailableId(id: minor_id)
    }
    
    //入力したminorに該当するナビゲーション情報を返す
    static func getNavigationText(minor_id : Int) -> String{
        return navigations.getNavigationText(id: minor_id)
    }

}
