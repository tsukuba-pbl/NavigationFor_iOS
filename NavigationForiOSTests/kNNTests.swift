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
        tData.append(knnData(X: [0, 0], routeId: 1))
        tData.append(knnData(X: [1, 0], routeId: 1))
        tData.append(knnData(X: [0, 1], routeId: 1))
        tData.append(knnData(X: [3, 2], routeId: 1))
        tData.append(knnData(X: [2, 2], routeId: 1))

        //交差点でないところで計測した値
        tData.append(knnData(X: [5, 6], routeId: 2))
        tData.append(knnData(X: [5, 6], routeId: 2))
        tData.append(knnData(X: [4, 5], routeId: 2))
        tData.append(knnData(X: [6, 7], routeId: 2))
        tData.append(knnData(X: [6, 8], routeId: 2))
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

