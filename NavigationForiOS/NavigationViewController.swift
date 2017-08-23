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
    
    var navigationservice : NavigationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationservice = NavigationService()

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
        let retval = navigationservice.updateNavigation()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
