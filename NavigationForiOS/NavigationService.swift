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
        
        return navDic
    }
}
