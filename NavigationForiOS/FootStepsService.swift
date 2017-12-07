//
//  FootStepsService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/12/06.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import AVFoundation

class FootStepsService: NSObject, AVSpeechSynthesizerDelegate{
    var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス
    //スレッド処理用
    var timer : Timer!
    
    var mode = -1
    
    override init(){
        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "se2", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            SlackService.postError(error: "AVAudioPlayerインスタンス作成失敗", tag: "SpeechService")
        }
        // バッファに保持していつでも再生できるようにする
        audioPlayerInstance.prepareToPlay()
    }
    
    public func changeIntervalAsCorrectNum(correctNum: Int){
        var newMode = -1
        var intervalTime = 2.0
        
        if(correctNum > 2){
            newMode = 3
            intervalTime = 0.5
        }else if(correctNum > 1){
            newMode = 2
            intervalTime = 1.0
        }else{
            newMode = 1
            intervalTime = 2.0
        }
        
        if(newMode != mode){
            if(self.timer != nil && self.timer.isValid){
                self.timer.invalidate()
            }
            self.timer = Timer.scheduledTimer(timeInterval: intervalTime, target: self, selector: #selector(FootStepsService.play), userInfo: nil, repeats: true)
            mode = newMode
        }
    }
    
    public func start(){
        let interval = 2.0
        self.timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(FootStepsService.play), userInfo: nil, repeats: true)
        mode = 1
    }
    
    public func stop(){
        if(self.timer.isValid){
            self.timer.invalidate()
        }
        mode = -1
    }
    
    func play(){
        audioPlayerInstance.play()
    }
}
