//
//  NavigationAlgorithmFactory.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

enum ALGORITHM_TYPE{
    case LPF
    case LPF_EUCLID
}

class NavigationAlgorithmFactory {
    
    static func getNavigationAlgorithm(type: ALGORITHM_TYPE) -> AlgorithmBase {
        var algorithm: AlgorithmBase? = nil
        switch type {
        case .LPF:
            algorithm = Lpf()
        case .LPF_EUCLID:
            algorithm = LpfEuclid()
        default:
            algorithm = Lpf()
        }
        return algorithm!
    }
}
