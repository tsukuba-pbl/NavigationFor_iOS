//
//  EventInfoViewController.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/10/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import UIKit
import Eureka

class EventInfoViewController:  FormViewController {
    
    var event: EventEntity? = nil
    var eventName: String!
    var eventDescription: String!
    var eventDate: String!
    var eventEndDate: String!
    var eventLocation: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.event = appDelegate.eventInfo!

        self.eventName = self.event?.name
        self.eventDescription = self.event?.description
        self.eventDate = self.event?.startDate
        self.eventEndDate = self.event?.endDate
        self.eventLocation = self.event?.location
        
        form
            +++ Section()
            <<< LabelRow(){
                $0.title = "イベント名"
                $0.value = self.eventName
            }
            
//            +++ Section(self.eventDescription)
            
            +++ Section()
            <<< LabelRow(){
                $0.title = "開始日時"
                $0.value = self.eventDate
            }
            <<< LabelRow(){
                $0.title = "終了日時"
                $0.value = self.eventEndDate
            }
            
            +++ Section()
            <<< LabelRow(){
                $0.title = "場所"
                $0.value = self.eventLocation
            }
                    
            // Button
            +++ Section()
            <<< ButtonRow(){
                $0.title = "ナビゲーションルートの選択"
                $0.onCellSelection{ [unowned self] cell, row in
                    let next = self.storyboard!.instantiateViewController(withIdentifier: "RouteStoryboard")
                    self.present(next,animated: true, completion: nil)
                }
        }

    }
    
}

