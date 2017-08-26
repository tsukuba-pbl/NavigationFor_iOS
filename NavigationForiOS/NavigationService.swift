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
        
    /// ナビゲーション情報をサーバからJSON形式で取得
    ///
    /// - Returns: NavigationEntity
    static func getNavigationData(responseNavigations: @escaping (NavigationEntity) -> Void){
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
    
}
