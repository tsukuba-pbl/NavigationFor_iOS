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
    func getMode(navigations: NavigationEntity) -> Int
    func getNavigation(navigations: NavigationEntity) -> String
    func getNavigationState() -> (state: String, currentRouteId: Int)
}

//ビーコン受信不能状態
class None: NavigationState{
    func getNavigationState() -> (state: String, currentRouteId: Int) {
        return ("None", currentRouteId)
    }

    private let currentRouteId: Int
    
    init(currentRouteId: Int){
        self.currentRouteId = currentRouteId
    }
    
    /// ナビゲーションテキストの取得
    ///
    /// - Parameter navigations: ナビゲーション情報
    /// - Returns: ナビゲーションテキスト
    func getNavigation(navigations: NavigationEntity) -> String {
        return "None"
    }
    
    func getMode(navigations: NavigationEntity) -> Int {
        return -1
    }
    
    /// ナビゲーション状態の更新をする関数
    ///
    /// - Parameters:
    ///   - navigationService: ナビゲーションサービス
    ///   - navigations: ナビゲーション情報
    ///   - receivedBeaconsRssi: その地点で取得したビーコン情報
    ///   - algorithm: 適用アルゴリズム
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {

        //受信できた場合、前進状態へ遷移
        if(!receivedBeaconsRssi.isEmpty){
            navigationService.navigationState = Start(currentRouteId: currentRouteId)
        }
    }
}

//前進状態
class Road: NavigationState{
    func getNavigationState() -> (state: String, currentRouteId: Int) {
        return ("Road", currentRouteId)
    }

    private let currentRouteId: Int
    
    init(currentRouteId: Int){
        self.currentRouteId = currentRouteId
    }
    
    /// ナビゲーションテキストの取得
    ///
    /// - Parameter navigations: ナビゲーション情報
    /// - Returns: ナビゲーションテキスト
    func getNavigation(navigations: NavigationEntity) -> String {
        return navigations.getNavigationText(route_id: currentRouteId)
    }
    
    func getMode(navigations: NavigationEntity) -> Int {
        return 1
    }
    
    /// ナビゲーション状態の更新をする関数
    ///
    /// - Parameters:
    ///   - navigationService: ナビゲーションサービス
    ///   - navigations: ナビゲーション情報
    ///   - receivedBeaconsRssi: その地点で取得したビーコン情報
    ///   - algorithm: 適用アルゴリズム
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: currentRouteId) {
            case .CROSSROAD :
                navigationService.navigationState = Crossroad(currentRouteId: currentRouteId+1)
            case .ROAD :
                navigationService.navigationState = Road(currentRouteId: currentRouteId)
            case .GOAL :
                navigationService.navigationState = Goal(currentRouteId: currentRouteId+1)
            case .OTHER: break
            default: break
        }

    }
    
}

//交差点到達状態
//指定方向に移動することで、次状態へ遷移
class Crossroad: NavigationState{
    func getNavigationState() -> (state: String, currentRouteId: Int) {
        return ("Crossroad", currentRouteId)
    }

    let motionService: MotionService
    private let currentRouteId: Int
    private let allowableDegree: Int = 10
    
    init(currentRouteId: Int){
        self.currentRouteId = currentRouteId
        motionService = MotionService()
        motionService.startMotionManager()
    }
    
    /// ナビゲーションテキストの取得
    ///
    /// - Parameter navigations: ナビゲーション情報
    /// - Returns: ナビゲーションテキスト
    func getNavigation(navigations: NavigationEntity) -> String {
        return navigations.getNavigationText(route_id: currentRouteId)
    }
    
    func getMode(navigations: NavigationEntity) -> Int {
        var retval = -1
        //右折のとき3,左折のとき2をリターン
        if(navigations.getNavigationDegree(route_id: currentRouteId) == 0){
            retval = 1
        }else if(navigations.getNavigationDegree(route_id: currentRouteId) > 0){
            retval = 2
        }else{
            retval = 3
        }
        return retval
    }
    
    /// ナビゲーション状態の更新をする関数
    ///
    /// - Parameters:
    ///   - navigationService: ナビゲーションサービス
    ///   - navigations: ナビゲーション情報
    ///   - receivedBeaconsRssi: その地点で取得したビーコン情報
    ///   - algorithm: 適用アルゴリズム
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        let rotateDegree = navigations.getNavigationDegree(route_id: currentRouteId)

        if (rotateDegree - allowableDegree < motionService.getYaw() && rotateDegree + allowableDegree > motionService.getYaw()) {
            motionService.stopMotionManager()
            navigationService.navigationState = Road(currentRouteId: currentRouteId + 1)
        }
    }
}

//ナビゲーション開始地点状態
class Start: NavigationState{
    func getNavigationState() -> (state: String, currentRouteId: Int) {
        return ("Start", currentRouteId)
    }
    
    private let currentRouteId: Int
    
    init(currentRouteId: Int){
        self.currentRouteId = currentRouteId
    }
    
    
    /// ナビゲーションテキストの取得
    ///
    /// - Parameter navigations: ナビゲーション情報
    /// - Returns: ナビゲーションテキスト
    func getNavigation(navigations: NavigationEntity) -> String {
        return navigations.getNavigationText(route_id: currentRouteId)
    }
    
    func getMode(navigations: NavigationEntity) -> Int {
        return 4
    }
    
    /// ナビゲーション状態の更新をする関数
    ///
    /// - Parameters:
    ///   - navigationService: ナビゲーションサービス
    ///   - navigations: ナビゲーション情報
    ///   - receivedBeaconsRssi: その地点で取得したビーコン情報
    ///   - algorithm: 適用アルゴリズム
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: currentRouteId) {
            case .CROSSROAD :
                navigationService.navigationState = Crossroad(currentRouteId: currentRouteId+1)
            case .ROAD :
                navigationService.navigationState = Road(currentRouteId: currentRouteId+1)
            case .START :
                navigationService.navigationState = Start(currentRouteId: currentRouteId)
            case .OTHER: break
            default: break
        }
    }
    
}


//目的地到達状態
class Goal: NavigationState{
    func getNavigationState() -> (state: String, currentRouteId: Int) {
        return ("Goal", currentRouteId)
    }

    private let currentRouteId: Int
    
    init(currentRouteId: Int){
        self.currentRouteId = currentRouteId
    }
    
    /// ナビゲーションテキストの取得
    ///
    /// - Parameter navigations: ナビゲーション情報
    /// - Returns: ナビゲーションテキスト
    func getNavigation(navigations: NavigationEntity) -> String {
        return navigations.getNavigationText(route_id: currentRouteId)
    }
    
    func getMode(navigations: NavigationEntity) -> Int {
        return 4
    }
    
    /// ナビゲーション状態の更新をする関数
    ///
    /// - Parameters:
    ///   - navigationService: ナビゲーションサービス
    ///   - navigations: ナビゲーション情報
    ///   - receivedBeaconsRssi: その地点で取得したビーコン情報
    ///   - algorithm: 適用アルゴリズム
    func updateNavigation(navigationService: NavigationService, navigations: NavigationEntity, receivedBeaconsRssi : Dictionary<Int, Int>, algorithm: AlgorithmBase) {
        
        switch algorithm.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: currentRouteId) {
            case .GOAL :
                navigationService.navigationState = Goal(currentRouteId: currentRouteId)
            case .OTHER: break
            default: break
        }
    }
    
}
