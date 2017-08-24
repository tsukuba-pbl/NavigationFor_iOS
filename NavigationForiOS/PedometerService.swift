//
//  PedometerService.swift
//  NavigationForiOS
//
//  Created by Owner on 2017/08/24.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import CoreMotion

class PedometerService {
    
    //歩数計測用変数
    let pedometer = CMPedometer()
    var steps = 0
    
    //歩数計測関数
    func pedoMeter() {
        self.pedometer.startUpdates(from: NSDate() as Date) {
            (data: CMPedometerData?, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if(error == nil) {
                    //歩数
                    self.steps = Int(data!.numberOfSteps)
                }
            })
        }
    }
    
    func get_steps() -> Int {
        return self.steps
    }
    
    func start_pedometer() {
        pedoMeter()
    }
    
    func stop_pedometer() {
        pedometer.stopUpdates()
        self.steps = 0
    }
}
