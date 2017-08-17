//
//  LocationService.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LocationService {
    
    
    /// 会場にある各地点の名前を取得
    ///
    /// - Returns: 地点を含む配列
    static func getLocations(responseLocations: @escaping ([String]) -> Void){
        Alamofire.request("https://gist.githubusercontent.com/ferretdayo/052e93d7c3067832e39f5ebe8cbfb004/raw/15ca9bb2263604b6027ed4b2bff36b7a1673be12/location.json")
        .responseJSON { response in
            var locations: [String] = []
            if let json = response.result.value {
                let locationJson = JSON(json)
                locationJson["locations"].forEach{(_, data) in
                    locations.append(data.string!)
                }
            }
            responseLocations(locations)
        }
    }
}
