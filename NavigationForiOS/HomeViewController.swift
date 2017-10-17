//
//  FirstViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/10.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {

//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventIdInputForm: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var events: [String] = []
    var searchedEvent: Dictionary<String, Any> = [:]
    
    // DI
    var eventService: EventService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.text = ""
//        eventService?.getEvents{ response in
//            self.events = response
//            self.tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func searchEvent(_ sender: Any) {
        if !self.eventIdInputForm.hasText {
            self.errorLabel.text = "イベントIDを入力してください"
            return
        }
        
        eventService?.searchEvents{ searchedEvent in
            self.searchedEvent = searchedEvent
            if self.searchedEvent["id"] != nil {
                // おｋ
                self.errorLabel.text = ""
                let next = self.storyboard!.instantiateViewController(withIdentifier: "EventViewStoryboard")
                self.present(next,animated: true, completion: nil)
            } else {
                self.errorLabel.text = "指定されたのイベントは存在しません"
            }
        }
    }
//    /// セルの個数を指定するデリゲートメソッド（必須）
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.events.count
//    }
//    
//    // セクションヘッダーの高さ
//    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    
//    /// セルに値を設定するデータソースメソッド（必須）
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        // セルを取得する
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath as IndexPath)
//        
//        // セルに表示する値を設定する
//        cell.textLabel!.text = self.events[indexPath.row]
//        
//        return cell
//    }
}

