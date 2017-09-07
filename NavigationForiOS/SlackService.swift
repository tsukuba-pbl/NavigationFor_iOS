//
//  SlackService.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/21.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import Alamofire

class SlackService {
    static let targetUrl_alert = "https://hooks.slack.com/services/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"
    static let targetUrl_log = "https://hooks.slack.com/services/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"
    static let channel = "#umesystems_alert"
    
    static func postError(error: String, tag: String) {
        request_alert(message: error, tag: tag)
    }
    
    private static func request_alert(message: String, tag: String) {
        let params: Parameters = [
            "attachments": [
                [
                    "fallback": tag,
                    "pretext": tag,
                    "color": "#D00000",
                    "fields": [
                        [
                            "title": "Error",
                            "value": message,
                            "short": false
                        ]
                    ]
                ],
            ],
        ]
        Alamofire.request(targetUrl_alert, method: .post, parameters: params, encoding: JSONEncoding.default)
    }
    
    static func postBeaconLog(log: String, tag: String) {
        request_log(message: log, tag: tag)
    }
    
    private static func request_log(message: String, tag: String) {
        let params: Parameters = [
            "attachments": [
                [
                    "fallback": tag,
                    "pretext": tag,
                    "color": "#0072d0",
                    "fields": [
                        [
                            "title": "Beacon Log Data",
                            "value": message,
                            "short": false
                        ]
                    ]
                ],
            ],
            ]
        Alamofire.request(targetUrl_log, method: .post, parameters: params, encoding: JSONEncoding.default)
    }
    
}
