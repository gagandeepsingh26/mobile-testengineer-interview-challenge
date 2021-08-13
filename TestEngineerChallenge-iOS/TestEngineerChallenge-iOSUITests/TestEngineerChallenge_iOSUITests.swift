//
//  TestEngineerChallenge_iOSUITests.swift
//  TestEngineerChallenge-iOSUITests
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import XCTest


class TestEngineerChallenge_iOSUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

    }
    // This test will fail because of BUG
    // After Logout Username and Password field are not cleared out
    func testLoginAndLogoutSubmitOnce() throws {
        let usernameTextField = app.textFields["username"]
        XCTAssert(usernameTextField.value as! String == "Username", "Expect TextField Empty or placeholer value")
        usernameTextField.tap()
        usernameTextField.typeText("test")
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()

        let passwordTextField = app.textFields["password"]
        // Another Bug here: placeholder value is "Pasword" instead of "Password"
        // Once fixed need to Update
        // worked around to complete the flow for Bug 2 in README
        XCTAssert(passwordTextField.value as! String == "Pasword", "Expect value Password")
        passwordTextField.tap()
        passwordTextField.typeText("test123")
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        
        let logoutButton = app.navigationBars["TestEngineerChallenge_iOS.LoggedInView"].buttons["Logout"]
        XCTAssert(logoutButton.waitForExistence(timeout: 10), "Expect logout button")
        logoutButton.tap()
        
        // Failed due to bug Number 1 in README
        XCTAssert(usernameTextField.value as! String == "Username", "Expect value Username")
        XCTAssert(passwordTextField.value as! String == "Password", "Expect value Password")
    }
    
    // This test will fail because of BUG 4 in README
    // One should not be able to click on Submit multiple time
    // Logout button vissible make this fail
    // Once fixed few changes in this test will be required
    func testLoginAndLogoutSubmitTwice() throws {
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("test")
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("test123")
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        if (submitStaticText.waitForExistence(timeout: 0) ) {
            submitStaticText.tap()
            sleep(5)
        }
        
        // Fails here because on Bug 4 in README
        let logoutButton = app.navigationBars["TestEngineerChallenge_iOS.LoggedInView"].buttons["Logout"]
        XCTAssert(logoutButton.waitForExistence(timeout: 3), "Expect Logout button")
    }
    
    // This test fails because of Bug 5 in README
    func testLoginAndLogoutSubmitWithSameUsername() throws {
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("test")
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("test123")
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()

        let logoutButton = app.navigationBars["TestEngineerChallenge_iOS.LoggedInView"].buttons["Logout"]
        XCTAssert(logoutButton.waitForExistence(timeout: 10), "Expect logout button")
        logoutButton.tap()
        
        submitStaticText.tap()
        
        // Fails here because on Bug 5 in README
        let errorStaticText = app.staticTexts["Error"]
        XCTAssert(errorStaticText.waitForExistence(timeout: 3), "Expect Error")
    }
    // Adding Few validation test to check error messages
    func testSignupWithNoUsernameAndPassword() throws {
        // Submit without Username and Password
        let signUpStaticText = app.staticTexts["Sign-Up"]
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        
        let errorStaticText = app.staticTexts["Error"]
        XCTAssert(errorStaticText.waitForExistence(timeout: 3), "Expect Error")
        
        let errorMsgStaticText = app.staticTexts["Missing username. Missing password."]
        XCTAssert(errorMsgStaticText.waitForExistence(timeout: 3), "Expect Missing username. Missing password.")
        
        let okButton = app.alerts["Error"].scrollViews.otherElements.buttons["Ok"]
        okButton.tap()
        XCTAssert(signUpStaticText.waitForExistence(timeout: 3), "Expect SignUp page")
    }
        
    func testSignupWithSmallUsernameAndNoPassword() throws {
        // submit with small username and no password
        let usernameTextField = app/*@START_MENU_TOKEN@*/.textFields["username"]/*[[".otherElements[\"authentication\"]",".textFields[\"Username\"]",".textFields[\"username\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        usernameTextField.tap()
        usernameTextField.typeText("te")
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        
        let errorStaticText = app.staticTexts["Error"]
        XCTAssert(errorStaticText.waitForExistence(timeout: 3), "Expect Error")
        
        let errorMsgStaticText = app.staticTexts["Missing password. username is too small, currently 2 characters, minimum is 3."]
        XCTAssert(errorMsgStaticText.waitForExistence(timeout: 3), "Expect Missing password. username is too small, currently 2 characters, minimum is 3.")
    }
        
        
    func testSignupWithLargeUsernameAndValidPassword() throws {
        // submit with large username and valid password
        let usernameTextField = app/*@START_MENU_TOKEN@*/.textFields["username"]/*[[".otherElements[\"authentication\"]",".textFields[\"Username\"]",".textFields[\"username\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        usernameTextField.tap()
        usernameTextField.typeText("testing12345678")
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let passwordTextField = app/*@START_MENU_TOKEN@*/.textFields["password"]/*[[".otherElements[\"authentication\"]",".textFields[\"Pasword\"]",".textFields[\"password\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        passwordTextField.tap()
        passwordTextField.typeText("testing")
        
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        
        let errorStaticText = app.staticTexts["Error"]
        XCTAssert(errorStaticText.waitForExistence(timeout: 3), "Expect Error")
        
        let errorMsgStaticText = app.staticTexts["username is too large, currently 15 characters, maximum is 10."]
        XCTAssert(errorMsgStaticText.waitForExistence(timeout: 3), "username is too large, currently 15 characters, maximum is 10.")
    }
    
    func testSignupWithValidUsernameAndLargePassword() throws {
        // submit with valid username and large password
        let usernameTextField = app/*@START_MENU_TOKEN@*/.textFields["username"]/*[[".otherElements[\"authentication\"]",".textFields[\"Username\"]",".textFields[\"username\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        usernameTextField.tap()
        usernameTextField.typeText("test")
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let passwordTextField = app/*@START_MENU_TOKEN@*/.textFields["password"]/*[[".otherElements[\"authentication\"]",".textFields[\"Pasword\"]",".textFields[\"password\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        passwordTextField.tap()
        passwordTextField.typeText("testing123456789")
        
        returnButton.tap()
        
        let submitStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".otherElements[\"authentication\"]",".buttons[\"Submit\"].staticTexts[\"Submit\"]",".buttons[\"submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitStaticText.tap()
        
        let errorStaticText = app.staticTexts["Error"]
        XCTAssert(errorStaticText.waitForExistence(timeout: 3), "Expect Error")
        
        let errorMsgStaticText = app.staticTexts["password is too large, currently 16 characters, maximum is 15."]
        XCTAssert(errorMsgStaticText.waitForExistence(timeout: 3), "password is too large, currently 16 characters, maximum is 15.")
    }
}
