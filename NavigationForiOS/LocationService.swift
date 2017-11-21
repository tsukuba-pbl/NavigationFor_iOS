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
import UIKit
//
//class Manager {
//    static let sharedManager: Alamofire.SessionManager = {
//
//        // Create the server trust policies
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "example.com:80": .disableEvaluation
//        ]
//
//        // Create custom manager
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        let manager = Alamofire.SessionManager(
//            configuration: URLSessionConfiguration.default,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//        return manager
//    }()
//    private init() {
//    }
//}


class LocationService {
    
    /// 会場にある各地点の名前を取得
    ///
    /// - Returns: 地点を含む配列
    static func getLocations(responseLocations: @escaping ([String]) -> Void){

        let sharedManager: Alamofire.SessionManager = {
            
            // Create the server trust policies
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                "localhost:80": .pinCertificates(
                    certificates: ServerTrustPolicy.certificates(),
                    validateCertificateChain: false,
                    validateHost: true
                ),
            ]
            
            // Create custom manager
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            let manager = Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
            )
            return manager
        }()
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let eventInfo = appDelegate.eventInfo!
        if let eventId = eventInfo.id {
            Alamofire.request("https://localhost/api/events/0kzrV/locations")
                .responseJSON { response in
                    debugPrint(response)
                    var locations: [String] = []
                    switch response.result {
                    case .success(let response):
                        let locationJson = JSON(response)
                        locationJson["locations"].forEach{(_, data) in
                            locations.append(data["name"].string!)
                            
                        }
                        break
                    case .failure(let error):
                        SlackService.postError(error: error.localizedDescription, tag: "Location Service")
                        break
                    }
                    responseLocations(locations)
            }
        }
    }
}
