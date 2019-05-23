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

    var factsDetailVC: FactsDetailViewController?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        factsDetailVC = FactsDetailViewController()
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle(for: FactsDetailViewController.self))
        factsDetailVC  = (storyboard.instantiateViewController(withIdentifier: "FactsDetail") as! FactsDetailViewController)
        _ = factsDetailVC?.view
        factsDetailVC?.viewDidLoad()
        factsDetailVC?.didReceiveMemoryWarning()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        factsDetailVC = nil
    }

    func testOutlets() {
        XCTAssertNotNil(factsDetailVC?.descriptionLabel, "Outlets can't be nil")
        XCTAssertNotNil(factsDetailVC?.factImageView, "Outlets can't be nil")
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
