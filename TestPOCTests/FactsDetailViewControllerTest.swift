//
//  FactsDetailViewControllerTest.swift
//  TestPOCTests
//
//  Created by Praveen Kumar on 5/23/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import XCTest

@testable import TestPOC
class FactsDetailViewControllerTest: XCTestCase {

    var factsDetailVC = TestFactsDetailViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        _ = factsDetailVC.view
        factsDetailVC.viewDidLoad()
        factsDetailVC.didReceiveMemoryWarning()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOutlets() {
        XCTAssertNotNil(factsDetailVC.factDescriptionLabel, "can't be nil")
        XCTAssertNotNil(factsDetailVC.factImageView, "can't be nil")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
