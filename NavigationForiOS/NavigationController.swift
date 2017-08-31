//
//  NavigationStateMachine.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class NavigationController{
    updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode : Int, maxRssiBeacon: BeaconEntity, navigation_text : String){
    
    }
}

protocol State {
    func updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode : Int, maxRssiBeacon: BeaconEntity, navigation_text : String)
}

//前進状態
class GoFoward: State{
    func updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode: Int, maxRssiBeacon: BeaconEntity, navigation_text: String) {
        <#code#>
    }

    
}

//交差点到達状態
class OnThePoint: State{
    func updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode: Int, maxRssiBeacon: BeaconEntity, navigation_text: String) {
        <#code#>
    }

    
}

//右左折待機状態
class WaitTurn: State{
    func updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode: Int, maxRssiBeacon: BeaconEntity, navigation_text: String) {
        <#code#>
    }

    
}

//目的地到達状態
class Goal: State{
    func updateNavigation(navigationController: NavigationController, navigationEntity: NavigationEntity) -> (mode: Int, maxRssiBeacon: BeaconEntity, navigation_text: String) {
        <#code#>
    }

    
}
