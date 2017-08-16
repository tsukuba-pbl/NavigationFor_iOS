//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreLocation

class NavigationViewController: UIViewController, CLLocationManagerDelegate{
    
    
    let fruits = ["リンゴ", "みかん", "ぶどう"]
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ロケーションマネージャーを作成する
        self.trackLocationManager = CLLocationManager();
        
        //デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
