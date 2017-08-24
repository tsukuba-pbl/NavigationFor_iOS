//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class NavigationViewController: UIViewController{
    
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var navigation: UILabel!
    
    @IBOutlet weak var stepLabel: UILabel!
    
    var navigationDic = [Int: String]()
    
    var beaconservice : BeaconService!
    
    var uuidList : Array<String> = []
    var navigationcontroller : NavigationController!
    
    //歩数計測用変数
    let pedometer = CMPedometer()
    var pedoswitch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationcontroller = NavigationController()
        
        //表示をリセット
        reset()
        
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
        let retval = navigationcontroller.updateNavigation()
        let mode = retval.mode
        if(mode == -1){
            reset()
        }else{
            self.uuid.text = retval.uuid
            self.minor.text = "minor id : \(retval.minor_id)"
            self.rssi.text = "RSSI : \(retval.rssi)dB"
            self.navigation.text = retval.navigation_text
            if(mode == 2){
                goalAlert()
            }
        }
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
    
    //歩数計測のON/OFF切り替えボタン
    @IBAction func pedoMeterSwitch(_ sender: Any) {
        pedoswitch = !pedoswitch
        
        if(pedoswitch) {
            pedoMeter()
            print("歩数計ON")
        }
        else {
            self.pedometer.stopUpdates()
            self.stepLabel.text = "0"
            print("歩数計OFF")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
