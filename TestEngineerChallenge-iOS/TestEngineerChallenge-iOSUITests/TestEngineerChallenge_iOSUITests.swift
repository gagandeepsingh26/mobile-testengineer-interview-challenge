//
//  TestEngineerChallenge_iOSUITests.swift
//  TestEngineerChallenge-iOSUITests
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import XCTest

class TestEngineerChallenge_iOSUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
