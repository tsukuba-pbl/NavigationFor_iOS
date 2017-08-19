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
    
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var navigation: UILabel!
    
    var navigationDic = [Int: String]()
    
    var beaconservice : BeaconService!
    
    var planUUID : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BeaconService
        beaconservice = BeaconService()
        
        //使用するUUIDを取得
        planUUID = beaconservice.getUsingUUID()
        
        //表示をリセット
        reset()
        
        //ナビゲーションデータの取得
        NavigationService.getNavigations{response in
            self.navigationDic = response
        }
        
        // 初回
        updateNavigation()
        
        // 1秒ごとにビーコンの情報を取得する
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NavigationViewController.updateNavigation), userInfo: nil, repeats: true)
    }
    
    
    func reset(){
        self.uuid.text     = "none"
        self.minor.text    = "none"
        self.rssi.text     = "none"
        self.navigation.text = "none"
    }
    
    //ナビゲーションの更新
    func updateNavigation(){
        //現在の最大RSSIのビーコン情報を取得
        let retval = beaconservice.getMaxRssiBeacon()
        if(retval.flag == true){
            self.uuid.text = retval.uuid
            self.minor.text = "\(retval.minor)"
            self.rssi.text = "\(retval.rssi)"
            
            //ナビゲーションの更新
            //RSSI最大のビーコンのRSSIの値が-80dB以下のとき、案内が表示されるようにする
            if(isOnNavigationPoint(RSSI: retval.rssi, uuid: UUID(uuidString : retval.uuid)!, threshold: -80)){
                let navigationText = navigationDic[retval.minor]
                if(navigationText != nil){
                    self.navigation.text = navigationText
                }else{
                    self.navigation.text = "ルート上から外れている可能性があります"
                }
            }else{
                self.navigation.text = "進もう"
            }

        }else{
            reset()
        }
    }

    //ナビゲーションを行うタイミングを判定する
    //目的地もしくは交差点にいるかを判定する
    /// - Parameters:
    ///   - RSSI: 最大RSSIのビーコンのRSSI
    ///   - uuid: 最大RSSIのビーコンのuuid
    ///   - threshold : 閾値（RSSI）
    /// - Returns: 入力が正しければtrue，正しくなければfalse
    func isOnNavigationPoint(RSSI : Int, uuid : UUID, threshold : Int) -> Bool {
        var flag: Bool = false
        //使用するUUIDと一致しており、かつ閾値よりも大きいRSSI
        if(uuid.uuidString == planUUID && RSSI > threshold){
            flag = true
        }
        return flag
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
