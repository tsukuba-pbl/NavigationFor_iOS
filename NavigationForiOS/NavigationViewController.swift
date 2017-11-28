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

    @IBOutlet weak var currentPointLabel: UILabel!
    
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
    
    var routeDeparture: String! //出発地
    var routeDestination: String! //目的地
    var arrivalFlag = true
    
    //スレッド処理用
    var navigationTimer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RouteViewControllerで設定した目的地をAppDelegateから取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        routeDestination = appDelegate.destination!
        routeDeparture = appDelegate.departure!
        let eventId = appDelegate.eventInfo!.id
        
        // ナビゲーションの情報の取得
        navigationService?.getNavigationData(eventId: eventId!, departure: routeDeparture, destination: routeDestination, responseNavigations: {response in
            if response.hasNavigation() {
                self.navigations = response
                self.navigationService?.initNavigation(navigations: self.navigations!)
                self.updateNavigation()
                // 1秒ごとにビーコンの情報を取得する
                self.navigationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(NavigationViewController.updateNavigation), userInfo: nil, repeats: true)
            } else {
                self.toast(message: "ルート情報がありません．．．") {
                    let next = self.storyboard!.instantiateViewController(withIdentifier: "routes")
                    self.present(next,animated: true, completion: nil)
                }
                
            }
        })
        
        //画像の読み込み
        imgFoward = UIImage(named: "foward.png")
        imgLeft = UIImage(named: "left.png")
        imgRight = UIImage(named: "right.png")
        
        //表示をリセット
        reset()
        
        navigation.adjustsFontSizeToFitWidth = true
        
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
                if (arrivalFlag) {
                    arrivalToSlack()
                }
                //スレッド処理を停止する
                if(navigationTimer.isValid){
                    navigationTimer.invalidate()
                }
                goalAlert()
            default: break //その他
            }
        }
        
        self.textField.text = "".appendingFormat("%.2f", (magneticSensorSerivce?.getMagneticDirection())!)
        
        //現在位置の表示
        let currentRouteId = navigationService?.getCurrentRouteId(navigations: navigations!)
        currentPointLabel.text = "KNN Route ID : \(currentRouteId ?? -1)"
    }
    
    //スタッフにヘルプボタンが押された時
    @IBAction func didTouchHelp(_ sender: Any) {
        //現在位置を取得
        let currentRouteId = navigationService?.getCurrentRouteId(navigations: navigations!)

        SlackService.postHelp(name: "Minajun", routeId: currentRouteId!)
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
    
    func arrivalToSlack() {
        arrivalFlag = false
        SlackService.postArrival(name: "A", destination: routeDestination)
    }
    
    //左上のRouteButtonが押されたときの処理
    @IBAction func didTouchRouteButton(_ sender: Any) {
        //スレッド処理を停止する
        if(navigationTimer.isValid){
            navigationTimer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        magneticSensorSerivce?.stopMagineticSensorService()
    }

}


extension UIViewController {
    func toast(message: String, callback: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                alert.dismiss(animated: true, completion: nil)
                callback()
            })
        })
    }
}
