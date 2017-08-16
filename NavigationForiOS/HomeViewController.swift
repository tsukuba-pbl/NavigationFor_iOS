//
//  FirstViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/10.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let fruits = ["リンゴ", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう", "みかん", "ぶどう"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fruits.count
    }
    
    // セクションヘッダーの高さ
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath as IndexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = self.fruits[indexPath.row]
        
        return cell
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル番号：\(indexPath.row) セルの内容：\(self.fruits[indexPath.row])")
    }
}

