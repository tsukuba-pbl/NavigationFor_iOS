//
//  Const.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/11/22.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class Const : NSObject {
  
    /* API URLs */
    #if DEBUG
    let URL_API = "http://localhost/api"
    #else
    let URL_API = "https://mizugorou.site/api"
    #endif
    
    
    let stepLength = 0.78
}
