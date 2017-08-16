//
//  RouteViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/16.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import Eureka

class RouteViewController: FormViewController {
    
    let point: NSArray = ["入り口", "受付", "会場A", "会場B"]
    var source: String = ""
    var destination: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.source = self.point[0] as! String
        // Do any additional setup after loading the view, typically from a nib.
            
        form
        +++ Section("Source")
            <<< PushRow<String>(){
                $0.title = "現在地"
                $0.selectorTitle = "現在地の選択"
                $0.options = self.point as! [String]
                $0.onChange{[unowned self] row in
                    self.source = row.value ?? self.point[0] as! String
                }
            }
            
                    
        +++ Section("Destination")
            <<< PushRow<String>(){
                $0.title = "目的地"
                $0.selectorTitle = "目的地の選択"
                $0.options = self.point as! [String]
                $0.onChange{[unowned self] row in
                    self.destination = row.value ?? self.point[0] as! String
                }
            }
        
            // Button
        +++ Section()
            <<< ButtonRow(){
                $0.title = "Start Navigation"
                $0.onCellSelection{ [unowned self] cell, row in
                    if self.isSuccessLocationInput(source: self.source, destination: self.destination) {
                        let next = self.storyboard!.instantiateViewController(withIdentifier: "NavigationStoryboard")
                        self.present(next,animated: true, completion: nil)
                    }
                }
        }
    }
    
    /// 入力された場所が正しい入力かどうかの判定を行う関数
    ///
    /// - Parameters:
    ///   - source: 現在地の場所
    ///   - destination: 目的地の場所
    /// - Returns: 入力が正しければtrue，正しくなければfalse
    func isSuccessLocationInput(source: String, destination: String) -> Bool {
        var success: Bool = true
        if source == "" || destination == "" {
            self.makeAlert(title: "Error", message: "現在地または目的地に場所を入れてください")
            success = false
        } else if source == destination {
            self.makeAlert(title: "Error", message: "現在地と目的地は異なる場所を入れてください")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

