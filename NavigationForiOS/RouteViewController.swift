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
    
    var point: [String] = []
    var departure: String = ""
    var destination: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // API的に対象の地点を取得し，Formの選択データにセット
        LocationService.getLocations{ responseLocations in
            self.point = responseLocations
            
            if let LocationsRow = self.form.rowBy(tag: "SourceLocations") {
                LocationsRow.updateCell()
            }
            
            if let LocationsRow = self.form.rowBy(tag: "DestinationLocations") {
                LocationsRow.updateCell()
            }
        }
            
        form
        +++ Section("Source")
            <<< PushRow<String>("SourceLocations"){
                $0.title = "出発地"
                $0.selectorTitle = "出発地の選択"
                $0.options = self.point
                $0.onChange{[unowned self] row in
                    self.departure = row.value ?? self.point[0]
                }
            }.cellUpdate { cell, row in
                row.options = self.point
            }
            
                    
        +++ Section("Destination")
            <<< PushRow<String>("DestinationLocations"){
                $0.title = "目的地"
                $0.selectorTitle = "目的地の選択"
                $0.options = self.point
                $0.onChange{[unowned self] row in
                    self.destination = row.value ?? self.point[0]
                }
            }.cellUpdate { cell, row in
                row.options = self.point
            }
        
            // Button
        +++ Section()
            <<< ButtonRow(){
                $0.title = "Start Navigation"
                $0.onCellSelection{ [unowned self] cell, row in
                    if self.isSuccessLocationInput(source: self.departure, destination: self.destination) {
                        //次のビュー(NavigationViewController)用に目的地の値を保持する
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.destination = self.destination
                        appDelegate.departure = self.departure
                        let next = self.storyboard!.instantiateViewController(withIdentifier: "NavigationStoryboard")
                        self.present(next,animated: true, completion: nil)
                    }
                }
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}

