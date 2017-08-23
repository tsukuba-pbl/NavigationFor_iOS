//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreLocation

class NavigationViewController: UIViewController{
    
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var navigation: UILabel!
    
    var beaconservice : BeaconService!
    
    var uuidList : Array<String> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Beaconの初期設定
        initBeaconService()
        
        //表示をリセット
        reset()
        
        //ナビゲーションデータの読み込み
        NavigationService.getNavigationData{response in

        }
        
        // 初回
        updateNavigation()
        
        // 1秒ごとにビーコンの情報を取得する
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NavigationViewController.updateNavigation), userInfo: nil, repeats: true)
    }
    
    //Beaconの初期設定
    func initBeaconService(){
        //BeaconServiceのインスタンス生成
        beaconservice = BeaconService()
        //使用するUUIDを発行
        uuidList = beaconservice.getUsingUUIDs()
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
            self.minor.text = "minor id : \(retval.minor)"
            self.rssi.text = "RSSI : \(retval.rssi)dB"
            
            //ナビゲーションの更新
            //RSSI最大のビーコンのRSSIの値が-80dB以下のとき、案内が表示されるようにする
            if(isOnNavigationPoint(RSSI: retval.rssi, uuid: UUID(uuidString : retval.uuid)!, threshold: -80)){
                //ゴールに到着したかを判定
                if(NavigationService.isGoal(minor_id: retval.minor)){
                    //到着した
                    self.navigation.text = "Goal"
                    goalAlert()
                }else{
                    //到着してない　途中のとき
                    //ルート上のビーコンか判定
                    if(NavigationService.isAvailableBeacon(minor_id: retval.minor)){
                        self.navigation.text = NavigationService.getNavigationText(minor_id: retval.minor)
                    }else{
                        self.navigation.text = "ルート上から外れている可能性があります"
                    }
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
        if(uuidList.contains(uuid.uuidString) == true && RSSI > threshold){
            flag = true
        }
        return flag
    }
    
    //ゴール時にアラートを表示する
    func goalAlert(){
        //① コントローラーの実装
        let alertController = UIAlertController(title: "Navigation", message: "目的地に到着しました",  preferredStyle: UIAlertControllerStyle.alert)
        
        //②-1 OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            //②-2 OKがクリックされた時の処理
            //Route画面へ移動
            let next = self.storyboard!.instantiateViewController(withIdentifier: "routes")
            self.present(next, animated: true, completion: nil)
        }
        //③-1 ボタンに追加
        alertController.addAction(okAction)
        
        //④ アラートの表示
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
