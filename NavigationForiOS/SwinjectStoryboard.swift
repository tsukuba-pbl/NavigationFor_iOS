//
//  File.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/27.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    class func setup() {
        
        let container = defaultContainer
        
        container.register(BeaconService.self) { _ in
            BeaconService()
        }
        
        container.register(PedometerService.self) { _ in
            PedometerService()
        }
        
        container.register(NavigationService.self) { r in
            NavigationService(beaconService: r.resolve(BeaconService.self)!)
        }
        
        container.storyboardInitCompleted(NavigationViewController.self) { (r, vc) in
            vc.navigationService = r.resolve(NavigationService.self)!
            vc.pedometerService = r.resolve(PedometerService.self)!
        }
    }
}
