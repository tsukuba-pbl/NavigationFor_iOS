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
    /// - Returns: minor値とナビゲーションを対応させたDictionary
    static func getNavigationJSON(responseNavigations: @escaping (Dictionary<Int,String>) -> Void){
        var navDic = [Int: String]() //minorとナビゲーション内容を対応させたDictionary
        let requestUrl = "https://gist.githubusercontent.com/Minajun/f59deb00034b21342ff79c26d3658fff/raw/7f5b9c8b632a825bf2584c26869c57826351f005/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["navigations"].forEach{(_, data) in
                    //Dictionaryにペアとして追加（key:minor val:navigation）
                    let minor = data["minor"].int!
                    let navigation = data["navigation"].string!
                    navDic[minor] = navigation
                    print("\(minor):\(navigation)")
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navDic)
        }
    }
}
