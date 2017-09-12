//
//  kNNTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/12.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class kNNTests: XCTestCase {
    let kNN = KNN()
    
    //routeId = 1 交差点にいる routeId = 2 交差点にいない
    var tData = [knnData]()
    
    override func setUp() {
        super.setUp()
        
        //教師データの作成
        //交差点で計測した値
        tData.append(knnData(X: [-75, -74, -65, -95, -100, -99], routeId: 1))
        tData.append(knnData(X: [-70, -75, -70, -92, -90, -100], routeId: 1))
        tData.append(knnData(X: [-70, -73, -56, -95, -100, -99], routeId: 1))
        tData.append(knnData(X: [-65, -73, -60, -95, -89, -95], routeId: 1))
        tData.append(knnData(X: [-64, -80, -74, -86, -95, -100], routeId: 1))
        tData.append(knnData(X: [-75, -79, -69, -99, -96, -99], routeId: 1))
        tData.append(knnData(X: [-73, -72, -57, -100, -91, -90], routeId: 1))
        tData.append(knnData(X: [-73, -69, -55, -100, -93, -89], routeId: 1))
        tData.append(knnData(X: [-70, -75, -65, -90, -100, -88], routeId: 1))
        tData.append(knnData(X: [-80, -65, -65, -90, -95, -91], routeId: 1))
        
        //交差点でないところで計測した値
        tData.append(knnData(X: [-95, -100, -99, -75, -74, -65], routeId: 2))
        tData.append(knnData(X: [-92, -90, -100, -70, -75, -70,], routeId: 2))
        tData.append(knnData(X: [-100, -90, -89, -95, -100, -99], routeId: 2))
        tData.append(knnData(X: [-95, -89, -95, -65, -73, -60], routeId: 2))
        tData.append(knnData(X: [-86, -95, -100, -73, -69, -55], routeId: 2))
        tData.append(knnData(X: [-99, -96, -99, -80, -65, -65], routeId: 2))
        tData.append(knnData(X: [-100, -91, -90, -100, -93, -89], routeId: 2))
        tData.append(knnData(X: [-100, -93, -89, -90, -95, -91], routeId: 2))
        tData.append(knnData(X: [-90, -100, -88, -100, -90, -89], routeId: 2))
        tData.append(knnData(X: [-90, -95, -91, -100, -90, -89], routeId: 2))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKnn(){
        //教師データの正答率を調べる
        let accuracy = kNN.getKnnAccuracy(trainData: tData)
        print("正答率：\(accuracy)")
        
        //とりあえず、正答率9割超えていたら大丈夫とする
        XCTAssertTrue(accuracy > 0.9)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

