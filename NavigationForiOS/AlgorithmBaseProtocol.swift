//
//  AlgorithmBase.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol AlgorithmBaseProtocol {
    func getCurrentPoint(navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, expectedBeaconsRssi: Dictionary<Int, Int>) -> POINT
    func getRouteId(navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>) -> Int
}
