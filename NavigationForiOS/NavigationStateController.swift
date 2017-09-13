//
//  NavigationState.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol NavigationState {
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase)
    func getMode() -> Int
    func getNavigation(navigations: NavigationEntity) -> String
    
}

//ビーコン受信不能状態
class None: NavigationState{
    private let expectedRouteId: Int
    
    init(expectedRouteId: Int){
        self.expectedRouteId = expectedRouteId
    }
    
    func getNavigation(navigations: NavigationEntity) -> String {
        return "None"
    }
    
    func getMode() -> Int {
        return -1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {

        //受信できた場合、前進状態へ遷移
        if(!receivedBeaconsRssi.isEmpty){
            SlackService.postError(error: "None状態", tag: "State")
            navigationService.navigationState = GoFoward(expectedRouteId: expectedRouteId)
        }
    }
}

//前進状態
class GoFoward: NavigationState{
    private let expectedRouteId: Int
    
    init(expectedRouteId: Int){
        self.expectedRouteId = expectedRouteId
    }
    
    func getNavigation(navigations: NavigationEntity) -> String {
        return "進もう"
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, expectedRouteId: expectedRouteId) {
        case .CROSSROAD :
            //SlackService.postError(error: "GoFoward: CROSSROAD", tag: "State")
            navigationService.navigationState = OnThePoint(expectedRouteId: expectedRouteId+1)
        case .OTHER :
            //SlackService.postError(error: "GoFoward: OTHER", tag: "State")
            navigationService.navigationState = GoFoward(expectedRouteId: expectedRouteId)
        case .START : break
        case .GOAL :
            //SlackService.postError(error: "GoFoward: GOAL", tag: "State")
            navigationService.navigationState = Goal(expectedRouteId: expectedRouteId+1)
        }

    }
    
}

//交差点到達状態
//指定方向に移動することで、次状態へ遷移
class OnThePoint: NavigationState{
    let motionService: MotionService
    private let expectedRouteId: Int
    private let allowableDegree: Int = 10
    
    init(expectedRouteId: Int){
        self.expectedRouteId = expectedRouteId
        motionService = MotionService()
        motionService.startMotionManager()
    }
    
    func getNavigation(navigations: NavigationEntity) -> String {
        return navigations.getNavigationText(route_id: expectedRouteId)
    }
    
    func getMode() -> Int {
        return 1
    }
    
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        let rotateDegree = navigations.getNavigationDegree(route_id: expectedRouteId)
        //SlackService.postError(error: "OnThePOINT: なう, rotate: \(rotateDegree), actial: \(motionService.getYaw())", tag: "State")
        
        if (rotateDegree - allowableDegree < motionService.getYaw() && rotateDegree + allowableDegree > motionService.getYaw()) {
            //SlackService.postError(error: "OnThePOINT: まがれた", tag: "State")
            motionService.stopMotionManager()
            navigationService.navigationState = GoFoward(expectedRouteId: expectedRouteId + 1)
        }
    }
}

//目的地到達状態
class Goal: NavigationState{
    private let expectedRouteId: Int
    
    init(expectedRouteId: Int){
        self.expectedRouteId = expectedRouteId
    }
    
    func getNavigation(navigations: NavigationEntity) -> String {
        return "Goal"
    }
    
    func getMode() -> Int {
        return 2
    }
    
    //呼ばれない関数
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        //SlackService.postError(error: "GOAL: まがれた", tag: "State")
        
    }
    
}
