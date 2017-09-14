//
//  BeaconLoggerViewController.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/06.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit

class BeaconLoggerViewController: UIViewController, BeaconLoggerVCDelegate {
    @IBOutlet weak var startButton: UIButton! //計測開始ボタン
    @IBOutlet weak var routeIdLabel: UILabel!
    @IBOutlet weak var setRouteIdStepper: UIStepper!
    
    var navigations : NavigationEntity = NavigationEntity()
    var beaconLogger : BeaconLoggerController?
    
    @IBOutlet weak var loggerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var Counter: UILabel! //ビーコンの受信を行う回数を記録するカウンタ
    var timer : Timer!
    var onStart = false //計測中かどうか
    
    var routeId = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //最初はスタートボタンは押せる状態
        startButton.isEnabled = true
        Counter.text = "0"
        
        routeIdLabel.text = "\(routeId)"
        //くるくる設定
        loggerActivityIndicator.hidesWhenStopped = true
        
        //使用するビーコンのminor idを設定する
        //本当はここで、JSONとかを読み込んで設定したい
        for i in 1...9{
            navigations.MinorIdList.append(i)
        }
        //受信するビーコンの情報を与え、受信を開始する
        beaconLogger = BeaconLoggerController(navigations : navigations, delegate: self)
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        if(onStart == false){
            onStart = true
            startButton.setTitle("Stop", for: UIControlState.normal)
            startButton.backgroundColor = UIColor.red
            //Stepperを押せないようにする
            setRouteIdStepper.isEnabled = false
            //くるくる開始
            loggerActivityIndicator.startAnimating()
            //計測を開始する
            beaconLogger?.startBeaconLogger(routeId: routeId)
        }else{
            beaconLogger?.stopBeaconLogger()
            //ボタンの表示を変更
            startButton.setTitle("Start", for: UIControlState.normal)
            startButton.backgroundColor = UIColor.blue
            Counter.text = "0"
            //くるくる終了
            loggerActivityIndicator.stopAnimating()
            //Stepperの表示を変更
            setRouteIdStepper.value += 1.0
            routeId += 1
            routeIdLabel.text = "\(routeId)"
            setRouteIdStepper.isEnabled = true
            //フラグ処理
            onStart = false
        }
    }
    
    //ビューの更新
    func updateView(){
        let retval = beaconLogger?.getLoggerState()
        if(Counter.text != nil){
            Counter.text = "\(retval?.counter ?? 0)"
        }
    }
    
    /// Route Id 指定用のステッパの値が変更したとき
    @IBAction func didTapRouteIdStepper(_ stepper: UIStepper) {
        routeId = Int(stepper.value)
        routeIdLabel.text = "\(routeId)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
