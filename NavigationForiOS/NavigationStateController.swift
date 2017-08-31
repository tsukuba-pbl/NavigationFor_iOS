//
//  NavigationState.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol NavigationState {
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity)
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
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //受信できた場合、前進状態へ遷移
        if(available == true){
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
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //ビーコンが受信できてない場合は、ビーコン受信不能状態へ
        if(available == false){
            navigationService.navigationState = None()
            return
        }
        //RSSI最大のビーコンの閾値を取得し、ナビゲーションポイントに到達したかを判定する
        let threshold = navigations.getBeaconThreshold(minor_id: maxRssiBeacon.minorId)
        if(navigationService.isOnNavigationPoint(RSSI: maxRssiBeacon.rssi, threshold: threshold)){
            //ゴールに到着したかを判定
            if(maxRssiBeacon.minorId == navigations.goal_minor_id){
                //到着したとき、Goal状態へ遷移
                navigationService.navigationState = Goal()
                return
            }
            //交差点到達状態へ遷移
            navigationService.navigationState = OnThePoint()
        }
    }
    
}

//交差点到達状態
class OnThePoint: NavigationState{
    func getNavigation(navigations: NavigationEntity, maxRssiBeacon: BeaconEntity) -> String {
        return navigations.getNavigationText(minor_id: maxRssiBeacon.minorId)
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        //RSSI最大のビーコンの閾値を取得し、ナビゲーションポイントに到達したかを判定する
        //本当は、右に曲がったか左に曲がったかで判断する
        let threshold = navigations.getBeaconThreshold(minor_id: maxRssiBeacon.minorId)
        if(navigationService.isOnNavigationPoint(RSSI: maxRssiBeacon.rssi, threshold: threshold)){
            //ゴールに到着したかを判定
            if(maxRssiBeacon.minorId == navigations.goal_minor_id){
                //到着したとき、Goal状態へ遷移
                navigationService.navigationState = Goal()
                return
            }
        }else{
            //閾値を下回った場合、前進状態へ遷移
            navigationService.navigationState = GoFoward()
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
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, available: Bool, maxRssiBeacon: BeaconEntity) {
        
    }
    
}
