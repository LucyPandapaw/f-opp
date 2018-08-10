//
//  Assignment6UITests.swift
//  Assignment6UITests
//


import XCTest


class Assignment6UITests: XCTestCase {
    //from ass5 UItests
	// UI Tests Implementation
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        //count tableview
        let tables = app.tables
        XCTAssertEqual(tables.count, 1, "Table count is not 1")
        
        //        for index in 0..<tables.count {
        //            let table = tables.element(boundBy: index)
        //
        //            // Test each table
        //        }
        let table = tables.element(boundBy: 0)
        XCTAssertTrue(table.exists, "Table one does not exist")
        let cells = table.cells
        XCTAssertGreaterThan(cells.count, 0, "categories list does not contain more than 0 cells")
        let firstCell = cells.element(boundBy: 0)
        firstCell.tap()
        
        //        XCTAssertEqual(app.tables.count, 1, "One table element sited")
        //        //count cells
        //        XCTAssertGreaterThan(app.tables.cells.count, 0, "categories list contains more than 0 cells")
        //        //tap first cell, does it matter?
        //        app.tables.cells.staticTexts["Burmese"].tap()
        //app.tables.cells.staticTexts["Contains 3 images"].tap()
        //wait
        
        let navBar = app.navigationBars["Cat Images"]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        expectation(for: existsPredicate, evaluatedWith: navBar, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
        
        //count collectionview
        let collectionViews = app.collectionViews
        XCTAssertEqual(collectionViews.count, 1, "Collection view count is not 1")
        
        let collectionView = collectionViews.element(boundBy: 0)
        XCTAssertTrue(collectionView.exists, "Collection view does not exist")
        
        //count cells
        XCTAssertGreaterThan(collectionView.cells.count, 0, "cat images does not contain more than 0 cells")
    }
}
