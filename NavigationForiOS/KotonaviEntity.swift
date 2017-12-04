//
//  KotonaviEntity.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/12/01.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation

class KotonaviEntity{
    private var navigations: NavigationEntity
    private var kotonaviText = ""
    private var destination = ""
    private var departure = ""
    
    init(navigations: NavigationEntity, departure: String, destination: String){
        //ナビゲーション情報を格納
        self.navigations = navigations
        self.departure = departure
        self.destination = destination
        //ことなびを生成
        generateKotonabiText(navigations: navigations)
    }
    
    //ことナビを生成する
    private func generateKotonabiText(navigations: NavigationEntity){
        kotonaviText += departure + "から" + destination + "までの案内を行います。"
        kotonaviText += ""
    }
}
