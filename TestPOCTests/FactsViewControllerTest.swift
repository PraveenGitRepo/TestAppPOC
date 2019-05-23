//
//  FactsViewControllerTest.swift
//  TestPOCTests
//
//  Created by Praveen Kumar on 5/23/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import XCTest

@testable import TestPOC
class FactsViewControllerTest: XCTestCase {
    
    var factsVC = FactsViewController()
    var subViews: [UIView] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle(for: FactsViewController.self))
        factsVC  = (storyboard.instantiateViewController(withIdentifier: "FactsList") as! FactsViewController)
        _ = factsVC.view
        factsVC.viewDidLoad()
        subViews = factsVC.view.subviews
        factsVC.tableView.reloadData()
        factsVC.didReceiveMemoryWarning()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFactsListStoryBoard() {
        //Facts List StoryBoard related Unit test case
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle(for: FactsViewController.self))
        XCTAssertNotNil(storyboard, "Facts List Storyboard file not found")
    }

    func testFactsViewControllerConnected() {
        XCTAssertNotNil(factsVC, "FactsVC is not connected with a Storyboard")
    }
    
    func testFactsListVCIsComposedOfUITableView() {
        XCTAssertTrue(subViews.contains(factsVC.tableView), "ViewController under test is not composed of a UITableView")
    }
    
    func testOutlets() {
        XCTAssertNotNil(factsVC.tableView, "Outlets can't be nil")
    }
    
    func testConformsDataSourceAndDelegate() {
        XCTAssert((factsVC.conforms(to: UITableViewDataSource.self)), "does not conform to this protocol")
        XCTAssert((factsVC.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:)))), "does not respond to this seelctor")
        XCTAssert((factsVC.responds(to: #selector(UITableViewDataSource.tableView(_:cellForRowAt:)))), "does not respond to this seelctor")
    }
    
    func testTableCellforRowAtIndexPath() {
        guard let tableViewList = factsVC.tableView else {
            return
        }
        let cellTable = factsVC.tableView(tableViewList, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(cellTable.isKind(of: UITableViewCell.self) == true, "factsListVC - UITableViewCell is not created")
    }
    
    func testGetFactsApi() {
        factsVC.getFactsListData(endPointUrl: factsEndPoint, completion: { (error, jsonObject) in
            debugPrint("Finished in unit test!!!")
            debugPrint("----> Unit Test Response Data \(self.factsVC.rowsArray)")
        })
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
