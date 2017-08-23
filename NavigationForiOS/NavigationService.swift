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
    static var start_minor_id : Int!
    static var goal_minor_id : Int!
    static var navigations = [Int: String]()
    
    /// ナビゲーション情報をサーバからJSON形式で取得
    ///
    /// - Returns: minor値とナビゲーションを対応させたDictionary
    static func getNavigationJSON(responseNavigations: @escaping (Dictionary<Int,String>) -> Void){
        var navDic = [Int: String]() //minorとナビゲーション内容を対応させたDictionary
        let requestUrl = "https://gist.githubusercontent.com/Minajun/f59deb00034b21342ff79c26d3658fff/raw/8349150af8d3171a3a6ae31f9d078a19c4a59f6f/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["routes"].forEach{(_, data) in
                    //Dictionaryにペアとして追加（key:minor val:navigation）
                    let minor = data["minor"].int!
                    let navigation = data["navigation"].string!
                    navDic[minor] = navigation
                    print("\(minor):\(navigation)")
                }
                navigations = navDic
                //スタートとゴールのidを設定
                start_minor_id = navJson["start"].int!
                goal_minor_id = navJson["goal"].int!
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navDic)
        }
    }
    
    //入力したminorが、ゴールのidと同じかを判定する
    static func isGoal(minor_id : Int) -> Bool{
        print(goal_minor_id)
        return (minor_id == goal_minor_id)
    }

}
