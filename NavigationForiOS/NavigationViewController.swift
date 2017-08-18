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
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var navigation: UILabel!
    
    var navigationDic = [Int: String]()
    
    var beaconservice : BeaconService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BeaconService
        beaconservice = BeaconService()
        
        //表示をリセット
        reset()
        
        //ナビゲーションデータの取得
        NavigationService.getNavigations{response in
            self.navigationDic = response
            print(self.navigationDic.count)
        }
    }
    
    
    func reset(){
        self.status.text   = "none"
        self.uuid.text     = "none"
        self.major.text    = "none"
        self.minor.text    = "none"
        self.accuracy.text = "none"
        self.rssi.text     = "none"
        self.distance.text = "none"
        self.navigation.text = "none"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
