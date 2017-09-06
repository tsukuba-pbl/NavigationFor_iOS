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

    override func viewDidLoad() {
        super.viewDidLoad()

        //最初はスタートボタンは押せる状態
        startButton.isEnabled = true
        // Do any additional setup after loading the view.
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
    }

}
