//
//  SpeechService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/20.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechService : NSObject, AVSpeechSynthesizerDelegate{
    let speech = AVSpeechSynthesizer()
    
    func textToSpeech(str : String){
        let utterance = AVSpeechUtterance(string: str)//読み上げる文字
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")//読み上げの言語
        utterance.rate = 0.8 //読み上げの速度
        utterance.pitchMultiplier = 1.2 //声の高さ
        utterance.preUtteranceDelay = 0 //読み上げまでの待機時間
        utterance.postUtteranceDelay = 0 //読んだあとの待機時間
        speech.delegate = self
        speech.speak(utterance) //発話
    }

}
