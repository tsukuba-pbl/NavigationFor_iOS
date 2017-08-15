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
                    self.source = row.value ?? self.point[0] as! String
                }
            }
        
            // Button
        +++ Section()
            <<< ButtonRow(){
                $0.title = "Start Navigation"
                $0.onCellSelection{ [unowned self] cell, row in
                    let next = self.storyboard!.instantiateViewController(withIdentifier: "NavigationStoryboard")
                    self.present(next,animated: true, completion: nil)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

