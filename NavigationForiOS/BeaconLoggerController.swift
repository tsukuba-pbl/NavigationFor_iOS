//
//  BeaconLoggerController.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/08.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

protocol BeaconLoggerVCDelegate {
    func updateView()
}

class BeaconLoggerController : NSObject{
    var navigations : NavigationEntity = NavigationEntity()
    var beaconManager : BeaconManager = BeaconManager()
    var trainData : Array<Dictionary<Int, Int>> = []
    var timer : Timer!
    var getCounter = 0
    var state = false
    var delegate: BeaconLoggerVCDelegate?
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - navigations: 使用するビーコン情報の入ったナビゲーション情報
    init(navigations: NavigationEntity, delegate: BeaconLoggerVCDelegate){
        //使用するビーコン情報を格納
        self.navigations = navigations
        //デリゲートの設定
        self.delegate = delegate
        //受信するビーコンの情報を与え、受信を開始する
        beaconManager.startBeaconReceiver(navigations: self.navigations)
    }
    
    /// トレーニングデータの計測を開始する
    func startBeaconLogger(){
        // 1秒ごとにビーコンの情報を取得する
        getCounter = 0
        //格納配列を初期化
        trainData.removeAll()
        //スレッドの開始
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getBeaconRssi), userInfo: nil, repeats: true)
        state = true
    }
    
    //Loggerの状況を取得するメソッド
    func getLoggerState() -> (state: Bool, counter: Int){
        return (state, getCounter)
    }
    
    /// ビーコンの電波を受信するメソッド
    /// tapStartButton内のスレッド呼び出しによって、1秒ごとに呼ばれる
    func getBeaconRssi(){
        //取得した回数をカウント
        getCounter += 1
        //ビーコンの電波強度の計測
        let receivedBeaconsRssiList = beaconManager.getReceivedBeaconsRssi()
        //トレーニングデータに追加
        trainData.append(receivedBeaconsRssiList)
        //ビューを更新
        //テスト実行時には、呼び出さない
        #if DEBUG
            if(TestService.isTesting() == false){
                delegate?.updateView()
            }
        #else
            delegate?.updateView()
        #endif
    }
    
    /// 終了時に呼ぶ
    func stopBeaconLogger(){
        //スレッドを終了させる
        if(timer.isValid){
            timer.invalidate()
        }
        state = false
        //トレーニングデータを送信する
        sendTrainData()
    }
    
    //トレーニングデータを外部に送信する
    func sendTrainData(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let now = Date()
        var message = "Beacon Logger Train Data \n Date: \(formatter.string(from: now))\n"
        message += "route id, 1\n"
        message += "[\n"
        for i in trainData{
            message += "\t[\n"
            for j in navigations.getMinorList(){
                message += "\t\t{\"minorId\": \(j), \"rssi\": \(i[j] ?? -100)},\n"
            }
            message += "\t],\n"
        }
        message += "],\n"
        print(message)
        //SlackService.postBeaconLog(log: message, tag: "Beacon Logger")
    }

}
