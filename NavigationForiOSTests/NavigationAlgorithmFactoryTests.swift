//
//  NavigationAlgorithmFactoryTests.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/09/05.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class NavigationAlgorithmFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetNavigationAlgorithm_Lpfの場合() {
        XCTAssertTrue(NavigationAlgorithmFactory.getNavigationAlgorithm(type: ALGORITHM_TYPE.LPF) is Lpf)
    }
    
    func testGetNavigationAlgorithm_LpfEuclidの場合() {
        XCTAssertTrue(NavigationAlgorithmFactory.getNavigationAlgorithm(type: ALGORITHM_TYPE.LPF_EUCLID) is LpfEuclid)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
