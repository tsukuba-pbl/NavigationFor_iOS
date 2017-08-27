//
//  HomeViewControllerTests.swift
//  NavigationForiOS
//
//  Created by ともひろ on 2017/08/28.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class HomeViewControllerTests: XCTestCase {
    
    var homeViewController: HomeViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        self.homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoard") as? NavigationForiOS.HomeViewController
        self.homeViewController?.loadView()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewDidLoad() {
        //テスト用にNavigationServiceのモックを作成
        class MocEventService : EventService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getEvents(responseEvents: @escaping ([String]) -> Void) {
                return responseEvents(["enPiT", "アクセシビリティ研究会"])
            }
        }
        
        //NavigationServiceのBeaconServiceをモックに差し替え
        let eventService = MocEventService()
        self.homeViewController?.eventService = eventService
        self.homeViewController?.viewDidLoad()
        XCTAssertEqual((self.homeViewController?.events)!, ["enPiT", "アクセシビリティ研究会"])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
