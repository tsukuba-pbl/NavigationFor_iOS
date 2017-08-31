//
//  AttitudeService.swift
//  NavigationForiOS
//
//  Created by Owner on 2017/08/31.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import CoreMotion

class MotionService {
    
    // create instance of MotionManager
    let motionManager: CMMotionManager = CMMotionManager()
    var yaw: Int = 0
    
    init() {
        // Initialize MotionManager
        motionManager.deviceMotionUpdateInterval = 0.05 // 20Hz
    }

    func startMotionManager() {
        // Start motion data acquisition
        motionManager.startDeviceMotionUpdates( to: OperationQueue.current!, withHandler:{
            deviceManager, error in
    
            let attitude: CMAttitude = deviceManager!.attitude
            self.yaw = Int(attitude.yaw * 180.0 / Double.pi)
        })
    }
    
    func stopMotionManager() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func get_yaw() -> Int {
        return self.yaw
    }
}
