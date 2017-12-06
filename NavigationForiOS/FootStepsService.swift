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
    
    override init(){
        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "se1", ofType: "wav")!
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
        var intervalTime = 2.0
        
        if(correctNum > 5){
            intervalTime = 0.5
        }else if(correctNum > 3){
            intervalTime = 1.0
        }else{
            intervalTime = 2.0
        }
        
        if(self.timer.isValid){
            self.timer.invalidate()
        }
        self.timer = Timer.scheduledTimer(timeInterval: intervalTime, target: self, selector: #selector(FootStepsService.play), userInfo: nil, repeats: true)
    }
    
    public func start(){
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(FootStepsService.play), userInfo: nil, repeats: true)
    }
    
    public func stop(){
        if(self.timer.isValid){
            self.timer.invalidate()
        }
    }
    
    func play(){
        audioPlayerInstance.play()
    }
}
