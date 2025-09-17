//
//  TestInetumUITests.swift
//  TestInetumUITests
//
//  Created by Oleksandr Rustanovych on 16.09.2025.
//

import XCTest

final class TestInetumUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testInitialData() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let predicate = NSPredicate(format: "identifier CONTAINS 'item.'")
        let items = app.descendants(matching: .any).matching(predicate)
        XCTAssertTrue(items.count > 0, "experctting more than 0 items")
        
    }
    @MainActor
    func testSearchViewShown() throws {
        let app = XCUIApplication()
        app.launch()
        let searchView = app/*@START_MENU_TOKEN@*/.textFields["searchView"]/*[[".otherElements",".textFields[\"Suche\"]",".textFields[\"searchView\"]",".textFields"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchView.exists, "search view is not shown")
    }
    @MainActor
    func testexpandButtonState() throws {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["item.Bernd Schmitt"]/*[[".otherElements.buttons[\"item.Bernd Schmitt\"]",".buttons[\"item.Bernd Schmitt\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        let postText = app.staticTexts["7619*"]
        XCTAssertTrue(postText.exists, "expanded text is not shown")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
