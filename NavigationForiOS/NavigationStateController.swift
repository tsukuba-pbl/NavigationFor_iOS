//
//  NavigationState.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol NavigationState {
//    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity)
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase)
    func getMode() -> Int
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String
    
}

//ビーコン受信不能状態
class None: NavigationState{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "None"
    }
    
    func getMode() -> Int {
        return -1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {

        //受信できた場合、前進状態へ遷移
        if(!receivedBeaconsRssi.isEmpty){
            navigationService.navigationState = GoFoward()
        }
    }
}

//前進状態
class GoFoward: NavigationState{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "進もう"
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi) {
        case .CROSSROAD :
            navigationService.navigationState = OnThePoint()
        case .OTHER :
            navigationService.navigationState = GoFoward()
        case .START : break
        case .GOAL :
            navigationService.navigationState = Goal()
        default: break
        }

    }
    
}

//交差点到達状態
class OnThePoint: NavigationState{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return navigations.getNavigationText(route_id: navigations.getRouteIdFromMinorId(minor_id: maxRssiBeacon.minorId))
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi) {
        case .CROSSROAD :
            navigationService.navigationState = OnThePoint()
        case .OTHER :
            navigationService.navigationState = GoFoward()
        case .START : break
        case .GOAL :
            navigationService.navigationState = Goal()
        default: break
        }
    }
    
}
/*
 
 //右左折待機状態
 class WaitTurn: NavigationState{
 func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
 return "待機中"
 }
 
 func getMode() -> Int {
 return 1
 }
 
 func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
 
 }
 
 
 }
 
 */

//目的地到達状態
class Goal: NavigationState{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return "Goal"
    }
    
    func getMode() -> Int {
        return 2
    }
    
    //呼ばれない関数
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
    }
    
}
