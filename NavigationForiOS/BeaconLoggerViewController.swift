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
    
    var navigations : NavigationEntity!
    var beaconManager : BeaconManager = BeaconManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        //最初はスタートボタンは押せる状態
        startButton.isEnabled = true
        
        //使用するビーコンのminor idを設定する
        //本当はここで、JSONとかを読み込んで設定したい
        for i in 1...9{
            navigations.MinorIdList.append(i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        //計測中はスタートボタンが押せない状態にして、それがわかるようにする
        startButton.isEnabled = false
        startButton.setTitle("計測中", for: UIControlState.normal)
        startButton.backgroundColor = UIColor.red
        //受信するビーコンの情報を与え、受信を開始する
        beaconManager.startBeaconReceiver(navigations: self.navigations)
    }

}
