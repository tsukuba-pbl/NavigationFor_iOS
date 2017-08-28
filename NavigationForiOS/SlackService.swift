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
    static let targetUrl = "https://hooks.slack.com/services/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"
    static let channel = "#umesystems_alert"
    
    static func postError(error: String, tag: String) {
        request(message: error, tag: tag)
    }
    
    private static func request(message: String, tag: String) {
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
        Alamofire.request(targetUrl, method: .post, parameters: params, encoding: JSONEncoding.default)
    }
}
