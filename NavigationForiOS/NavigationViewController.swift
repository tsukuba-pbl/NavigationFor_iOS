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

class NavigationViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var stateMachineLabel: UILabel!
    @IBOutlet weak var navigation: UILabel!

    var pedoswitch = false
    
    var navigationDic = [Int: String]()
    
    // DI
    var pedometerService : PedometerService?
    var navigationService: NavigationService?
    var motionService : MotionService? = MotionService()
    var magneticSensorSerivce: MagneticSensorSerivce? = MagneticSensorSerivce()
    
    var navigations : NavigationEntity? //ナビゲーション情報
    
    //画像
    var imgFoward: UIImage!
    var imgLeft: UIImage!
    var imgRight: UIImage!
    @IBOutlet weak var navigationImg: UIImageView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationService?.getNavigationData{response in
            self.navigations = response
            self.navigationService?.initNavigation(navigations: self.navigations!)
            self.updateNavigation()
            // 1秒ごとにビーコンの情報を取得する
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NavigationViewController.updateNavigation), userInfo: nil, repeats: true)
        }
        
        //画像の読み込み
        imgFoward = UIImage(named: "foward.png")
        imgLeft = UIImage(named: "left.png")
        imgRight = UIImage(named: "right.png")
        
        //表示をリセット
        reset()
        
        magneticSensorSerivce?.startMagneticSensorService()
    }
    
    func reset(){
        self.navigation.text = "none"
        self.stateMachineLabel.text = "none"
    }
    
    //ナビゲーションの更新
    func updateNavigation(){
        let navigation = navigationService?.updateNavigation(navigations: self.navigations!)
        
        if(navigation?.mode == -1){
            reset()
        }else{
            self.navigation.text = navigation?.navigation_text
            self.stateMachineLabel.text = "State: \(navigation?.navigation_state ?? ""), Id: \(navigation?.expected_routeId ?? -1)"
            
            switch (navigation?.mode)! {
            case 1: //前進
                navigationImg.image = imgFoward
            case 2: //左折
                navigationImg.image = imgLeft
            case 3: //右折
                navigationImg.image = imgRight
            case 4: //目的地に到達
                goalAlert()
            default: break //その他
                
            }
        }
        
        self.textField.text = "".appendingFormat("%.2f", (magneticSensorSerivce?.getMagnetic())!)
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        magneticSensorSerivce?.stopMagineticSensorService()
    }
}
