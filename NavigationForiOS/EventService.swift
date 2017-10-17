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
    func getEvents(responseEvents: @escaping ([String]) -> Void){
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
    
    func searchEvents(responseEvents: @escaping (EventEntity) -> Void){
        Alamofire.request("https://gist.githubusercontent.com/ferretdayo/097f7baf8648770d345645cd9f4a3696/raw/43f634bd6248f9a72082b9b717a131844c4c8492/requestEventID.json")
        .responseJSON { response in
            var events: EventEntity? = nil
            switch response.result {
            case .success(let response):
                let eventJson = JSON(response)
                if eventJson["id"].string != nil {
                    events = EventEntity(id: eventJson["id"].string!, name: eventJson["name"].string!, info: eventJson["info"].string!, date: eventJson["date"].string!, location: eventJson["location"].string!)                }
                break
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Event Service")
                break
            }
            responseEvents(events!)
        }
    }
}
