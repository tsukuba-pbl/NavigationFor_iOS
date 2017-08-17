//
//  EventService.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventService {
    /// 会場にある各地点の名前を取得
    ///
    /// - Returns: 地点を含む配列
    static func getEvents(responseEvents: @escaping ([String]) -> Void){
        Alamofire.request("https://gist.githubusercontent.com/ferretdayo/b5743089f2d5f5468cca58ed9cf96b81/raw/2a6b2ca3937a61ab5b3a01ee30ecddb28103e41b/eventList.json")
            .responseJSON { response in
                var events: [String] = []
                if let json = response.result.value {
                    let eventJson = JSON(json)
                    eventJson["events"].forEach{(_, data) in
                        events.append(data.string!)
                    }
                }
                responseEvents(events)
        }
    }
}
