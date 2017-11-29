//
//  FirstViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/10.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import Eureka

class HomeViewController: FormViewController {
    
    var events: [String] = []
    var event: String = ""
    var eventService: EventService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // API的に対象のイベントを取得し，Formの選択データにセット
        eventService?.getEvents{ responseEvents in
            self.events = responseEvents
            
            if let EventRow = self.form.rowBy(tag: "SourceEvents") {
                EventRow.updateCell()
            }
        }
        
        form
            +++ Section()
            <<< PushRow<String>("SourceEvents"){
                $0.title = "イベントを選択"
                $0.selectorTitle = "イベント"
                $0.options = self.events
                $0.onChange{[unowned self] row in
                    self.event = row.value ?? self.events[0]
                }
                }.cellUpdate { cell, row in
                    row.options = self.events
            }

            // Button
            +++ Section()
            <<< ButtonRow(){
                $0.title = "イベントの表示"
                $0.onCellSelection{ [unowned self] cell, row in
                    if self.isSuccessLocationInput(event: self.event) {
                        //次のビュー(EventInfoViewController)用に目的地の値を保持する
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.event = self.event
                        let next = self.storyboard!.instantiateViewController(withIdentifier: "EventInfoStoryboard")
                        self.present(next,animated: true, completion: nil)
                    }
                }
        }
    }
    
    /// 入力された場所が正しい入力かどうかの判定を行う関数
    ///
    /// - Parameters:
    ///   - event: 選択したイベント
    /// - Returns: 入力が正しければtrue，正しくなければfalse
    func isSuccessLocationInput(event: String) -> Bool {
        var success: Bool = true
        if event == "" {
            self.makeAlert(title: "エラー", message: "イベントを選択してください")
            success = false
        }
        return success
    }

    /// アラートを作る関数
    ///
    /// - Parameters:
    ///   - title: アラートのタイトル
    ///   - message: アラートのメッセージ
    func makeAlert(title: String, message: String) -> Void {
        // アラートを作成
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        // アラートにボタンをつける
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }

}

