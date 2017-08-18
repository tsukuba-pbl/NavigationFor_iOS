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
    /// ナビゲーション情報を取得
    ///
    /// - Returns: minor値とナビゲーションを対応させたDictionary
    static func getNavigations() -> Dictionary<Int,String>{
        var navDic = [Int: String]() //minorとナビゲーション内容を対応させたDictionary
        
        //JSONを取得
        Alamofire.request("https://gist.githubusercontent.com/Minajun/f59deb00034b21342ff79c26d3658fff/raw/7f5b9c8b632a825bf2584c26869c57826351f005/navigationsList.json").responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["navigations"].forEach{(_, data) in
                    print("\(data["navigation"]) : \(data["minor"])")
                }
            case .failure(let error):
                print(error)
            }
        }
        return navDic
    }
}
