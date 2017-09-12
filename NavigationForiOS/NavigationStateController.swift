//
//  NavigationState.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol NavigationState {
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int)
    func getMode() -> Int
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String
    
}

//ビーコン受信不能状態
class None: NavigationState{
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String {
        return "None"
    }
    
    func getMode() -> Int {
        return -1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int) {

        //受信できた場合、前進状態へ遷移
        if(!receivedBeaconsRssi.isEmpty){
            navigationService.navigationState = GoFoward()
        }
    }
}

//前進状態
class GoFoward: NavigationState{
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String {
        return "進もう"
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, expectedRouteId: 1) {
        case .CROSSROAD :
            navigationService.navigationState = OnThePoint()
        case .OTHER :
            navigationService.navigationState = GoFoward()
        case .START : break
        case .GOAL :
            navigationService.navigationState = Goal()
        }

    }
    
}

//交差点到達状態
class OnThePoint: NavigationState{
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String {
        return navigations.getNavigationText(route_id: routeId)
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int) {
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, expectedRouteId: 1) {
        case .CROSSROAD :
            navigationService.navigationState = OnThePoint()
        case .OTHER :
            navigationService.navigationState = GoFoward()
        case .START : break
        case .GOAL :
            navigationService.navigationState = Goal()
        }
    }
    
}

 
//右左折待機状態
class WaitTurn: NavigationState{
    let motionService = MotionService()
    
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String {
        return "待機中"
    }
    
    func getMode() -> Int {
        return 1
    }
 
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi: Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int) {
        var rotateFlag = "left"
        let rotateDegree = navigations.getNavigationDegree(route_id: expectedRouteId)
        
        if (rotateDegree < 0) {
            rotateFlag = "right"
        }
        
        motionService.startMotionManager()
        
        if (rotateFlag == "left") {
            if (rotateDegree > motionService.getYaw()) {
                motionService.stopMotionManager()
                navigationService.navigationState = GoFoward()
            }
        }
        else if (rotateFlag == "right") {
            if (rotateDegree < motionService.getYaw()) {
                motionService.stopMotionManager()
                navigationService.navigationState = GoFoward()
            }
        }
        
    }
 
 }

//目的地到達状態
class Goal: NavigationState{
    
    func getNavigation(navigations: NavigationEntity, routeId: Int) -> String {
        return "Goal"
    }
    
    func getMode() -> Int {
        return 2
    }
    
    //呼ばれない関数
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase, expectedRouteId: Int) {
        
    }
    
}
