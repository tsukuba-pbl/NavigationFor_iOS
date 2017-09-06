//
//  BeaconLoggerViewController.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/06.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit

class BeaconLoggerViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton! //計測開始ボタン
    
    var navigations : NavigationEntity = NavigationEntity()
    var beaconManager : BeaconManager = BeaconManager()
    
    var trainData : Array<Dictionary<Int, Int>>? = nil
    
    @IBOutlet weak var getCounter: UILabel! //ビーコンの受信を行う回数を記録するカウンタ
    var getCounter2 = 0
    var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        //最初はスタートボタンは押せる状態
        startButton.isEnabled = true
        
        //使用するビーコンのminor idを設定する
        //本当はここで、JSONとかを読み込んで設定したい
        for i in 1...9{
            navigations.MinorIdList.append(i)
        }
        getCounter.text = "\(getCounter2)"
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        //計測中はスタートボタンが押せない状態にして、それがわかるようにする
        startButton.isEnabled = false
        startButton.setTitle("計測中", for: UIControlState.normal)
        startButton.backgroundColor = UIColor.red
        //トレーニングデータの配列の中身をクリア
        trainData = nil
        //受信するビーコンの情報を与え、受信を開始する
        beaconManager.startBeaconReceiver(navigations: self.navigations)
        getCounter2 = 0
        getCounter.text = "\(getCounter2)"
        // 1秒ごとにビーコンの情報を取得する
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BeaconLoggerViewController.getBeaconRssi), userInfo: nil, repeats: true)
    }
    
    
    /// ビーコンの電波を受信するメソッド
    /// tapStartButton内のスレッド呼び出しによって、1秒ごとに呼ばれる
    func getBeaconRssi(){
        //取得した回数をカウント
        getCounter2 += 1
        getCounter.text = "\(getCounter2)"
        //指定回数に達したら、スレッドを停止させる
        if(getCounter2 >= 10){
            timer.invalidate()
            startButton.isEnabled = true
            startButton.setTitle("計測開始", for: UIControlState.normal)
            startButton.backgroundColor = UIColor.blue
            getCounter2 = 0

        }
        //ビーコンの電波強度の計測
        let receivedBeaconsRssiList = beaconManager.getReceivedBeaconsRssi()
        //トレーニングデータに追加
        trainData?.append(receivedBeaconsRssiList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
