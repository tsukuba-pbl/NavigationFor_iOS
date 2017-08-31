//
//  MotionService.swift
//  NavigationForiOS
//
//  Created by Owner on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import CoreMotion

class MotionService {
    
    // create instance of MotionManager
    let motionManager = CMMotionManager()
    var yaw = 100
    
    init() {
        // Initialize MotionManager
        print("init")
        self.motionManager.deviceMotionUpdateInterval = 0.05 // 20Hz
    }
    
    func startMotionManager() {
        print("startMotionManager")
        // Start motion data acquisition
        self.motionManager.startDeviceMotionUpdates( to: OperationQueue.current!, withHandler:{
            deviceManager, error in
            
            let attitude: CMAttitude = deviceManager!.attitude
            self.yaw = Int(attitude.yaw * 180.0 / Double.pi)
            print("\(self.yaw)")
        })
    }
    
    func stopMotionManager() {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func get_yaw() -> Int {
        print("get")
        return self.yaw
    }
}

