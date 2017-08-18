//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreMotion

class NavigationViewController: UIViewController {
    
    let pedometer = CMPedometer()
    var pedoswitch = true
    
    @IBOutlet weak var stepLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //歩数計測関数
    func pedoMeter() {
        self.pedometer.startUpdates(from: NSDate() as Date) {
            (data: CMPedometerData?, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if(error == nil) {
                    //歩数
                    let steps = data!.numberOfSteps
                    self.stepLabel.text = steps.stringValue
                }
            })
        }
    }
    
    //歩数計のON/OFF
    @IBAction func pedoMeterSwitch(_ sender: Any) {
        pedoswitch = !pedoswitch
        
        if(pedoswitch) {
            pedoMeter()
            print("歩数計ON")
        }
        else {
            self.pedometer.stopUpdates()
            print("歩数計OFF")
        }
    }
}
