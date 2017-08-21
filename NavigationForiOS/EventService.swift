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
    /// イベントの名前を取得
    ///
    /// - Returns: イベントを含む配列
    static func getEvents(responseEvents: @escaping ([String]) -> Void){
        Alamofire.request("https://gist.githubusercontent.com/ferretdayo/b5743089f2d5f5468cca58ed9cf96b81/raw/2a6b2ca3937a61ab5b3a01ee30ecddb28103e41b/eventList.json")
        .responseJSON { response in
            var events: [String] = []
            switch response.result {
            case .success(let response):
                let eventJson = JSON(response)
                eventJson["events"].forEach{(_, data) in
                    events.append(data.string!)
                }
                break
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Event Service")
                break
            }
            responseEvents(events)
        }
    }
}
