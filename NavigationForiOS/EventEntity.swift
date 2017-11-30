//
//  EventEntity.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/10/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class EventEntity {
    var id: String?
    var name: String?
    var description: String?
    var startDate: String?
    var endDate: String?
    var location: String?
    
    init(id: String, name: String, description: String, startDate: String, endDate: String, location: String) {
        self.id = id
        self.name = name
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
    }
}
