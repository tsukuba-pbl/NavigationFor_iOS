//
//  NavigationViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import CoreLocation
import Swinject

class NavigationViewController: UIViewController{
    
    @IBOutlet weak var uuid: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var navigation: UILabel!
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!

    var pedoswitch = false
    
    var navigationDic = [Int: String]()
    
    // DI
    var pedometerService : PedometerService?
    var navigationService: NavigationService?
    var motionService : MotionService? = MotionService()
    
    var navigations : NavigationEntity? //ナビゲーション情報
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationService?.getNavigationData{response in
            self.navigations = response
            self.navigationService?.initNavigation(navigations: self.navigations!)
            self.updateNavigation()
            // 1秒ごとにビーコンの情報を取得する
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NavigationViewController.updateNavigation), userInfo: nil, repeats: true)
        }
        
        //表示をリセット
        reset()
    }
    
    func reset(){
        self.uuid.text     = "none"
        self.minor.text    = "none"
        self.rssi.text     = "none"
        self.navigation.text = "none"
    }
    
    //ナビゲーションの更新
    func updateNavigation(){
        let navigation = navigationService?.updateNavigation(navigations: self.navigations!)
        let maxRssiBeacon = navigationService?.getMaxRssiBeacon()
        
        if(navigation?.mode == -1){
            reset()
        }else{
            self.minor.text = "minor id : \(maxRssiBeacon?.minorId ?? 0)"
            self.rssi.text = "RSSI : \(maxRssiBeacon?.rssi ?? 0)dB"
            self.navigation.text = navigation?.navigation_text
            if(navigation?.mode == 2){
                goalAlert()
            }
        }
        
        //歩数取得
        let steps = pedometerService?.get_steps()
        self.stepLabel.text = "\(steps ?? 0)"
        
        //ヨー取得
        let direction_text = motionService?.getDirection()
        self.yawLabel.text = direction_text
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

    //歩数計測のON/OFF切り替えボタン
    @IBAction func pedoMeterSwitch(_ sender: Any) {
        pedoswitch = !pedoswitch
        
        if(pedoswitch) {
            pedometerService?.start_pedometer()
        }
        else {
            pedometerService?.stop_pedometer()
        }
    }

    @IBAction func motionStart(_ sender: Any) {
        motionService?.startMotionManager()
    }
    
    @IBAction func motionStop(_ sender: Any) {
        motionService?.stopMotionManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
