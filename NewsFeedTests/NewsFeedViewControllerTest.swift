//
//  NewsFeedViewControllerTest.swift
//  NewsFeedTests
//
//  Created by vishwanath kota on 12/08/2021.
//

import XCTest
@testable import NewsFeed

class NewsFeedViewControllerTest: XCTestCase {
    
    var controller: ViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self)).instantiateViewController(identifier: "ViewController") as? ViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        self.controller = controller
        self.controller.loadViewIfNeeded()
        self.controller.viewDidLoad()
        XCTAssertNotNil(controller.rowsTableView,
                        "Controller should have a tableview")
    }
    
    func testTableViewDelegateIsViewController() {
      XCTAssertTrue(controller.rowsTableView.delegate === controller,
                    "Controller should be delegate for the table view")
    }

    func testTableViewDataSourceIsViewController() {
      XCTAssertTrue(controller.rowsTableView.dataSource === controller,
                    "Controller should be delegate for the table view")
    }

}
