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
    
    var navigations : NavigationEntity = NavigationEntity()
    var beaconLogger : BeaconLoggerController?
    
    @IBOutlet weak var Counter: UILabel! //ビーコンの受信を行う回数を記録するカウンタ
    var timer : Timer!
    var onStart = false //計測中かどうか

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //最初はスタートボタンは押せる状態
        startButton.isEnabled = true
        Counter.text = "0"
        
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
            startButton.setTitle("計測終了", for: UIControlState.normal)
            startButton.backgroundColor = UIColor.red
            //計測を開始する
            beaconLogger?.startBeaconLogger()
        }else{
            beaconLogger?.stopBeaconLogger()
            startButton.setTitle("計測開始", for: UIControlState.normal)
            startButton.backgroundColor = UIColor.blue
            Counter.text = "0"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
