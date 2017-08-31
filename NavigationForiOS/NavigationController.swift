//
//  NavigationStateMachine.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class NavigationController{
    
}

protocol State {
    
}

//前進状態
class GoFoward: State{
    
}

//交差点到達状態
class OnThePoint: State{
    
}

//右左折待機状態
class WaitTurn: State{
    
}

//目的地到達状態
class Goal: State{
    
}
