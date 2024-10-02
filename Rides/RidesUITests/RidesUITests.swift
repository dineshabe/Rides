//
//  RidesUITests.swift
//  RidesUITests
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import XCTest

final class RidesUITests: XCTestCase {

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
    func testGetDisabled() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual(app.buttons["Get"].isEnabled, false)

        
        /*app.textFields["Enter the count of vehicles to fetch"].tap()
        

        pleaseEnterAValueBetween1And100StaticText.tap()
        pleaseEnterAValueBetween1And100StaticText.tap()*/

        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    @MainActor
    func testGetEnabled() throws {
        let app = XCUIApplication()
        app.launch()
        
        let textField = app.textFields["Enter the count of vehicles to fetch"]
        textField.tap()
        textField.typeText("1")
        XCTAssertEqual(app.buttons["Get"].isEnabled, true)
    }
    
    @MainActor
    func testValidationError() throws {
        let app = XCUIApplication()
        app.launch()
        
        let textField = app.textFields["Enter the count of vehicles to fetch"]
        textField.tap()
        textField.typeText("101")
        XCTAssertEqual(app.buttons["Get"].isEnabled, false)
        
        let validationErrorText = app.staticTexts["Please enter a value between 1 and 100"]
        XCTAssertEqual(validationErrorText.exists, true)
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
