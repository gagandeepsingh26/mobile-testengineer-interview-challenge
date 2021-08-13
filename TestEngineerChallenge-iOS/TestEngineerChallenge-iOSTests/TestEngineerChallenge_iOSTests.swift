//
//  TestEngineerChallenge_iOSTests.swift
//  TestEngineerChallenge-iOSTests
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import XCTest
@testable import TestEngineerChallenge_iOS

// Authenticator Result type is Comparable to facilitate unit testing.
// Can compare as XCTAssertEqual(result, .success()) or XCTAssertEqual(result, .failure(AuthenticatorError()))

class TestEngineerChallenge_iOSTests: XCTestCase {
    var sut: Authenticator!
    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = Authenticator()

    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }
    
    func testAuthenticatorWithValidUsernameAndPassword() {
        // given
        let username="username"
        let password="password"
        let expectedResult: Result<Bool, AuthenticatorError> = .success(true)

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedResult, "Expect no error for valid Username and Password")
    }

    func testAuthenticatorWithEmptyUsernameAndPassword() {
        // given
        let username=""
        let password=""
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.username, AuthenticatorError.Field.password]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect username and password missing error")
    }
    
    func testAuthenticatorWithValidUsernameAndEmptyPassword() {
        // given
        let username="testing"
        let password=""
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.password]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect password missing error")
    }
    
    func testAuthenticatorWithValidPasswordAndEmptyUsername() {
        // given
        let username=""
        let password="password"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.username]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect username missing error")
    }
    
    func testAuthenticatorWithEmptyUsernameAndSmallPassword() {
        // given
        let username=""
        let password="pass"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.username], outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.password, size: 4, min: 5)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect username missing and Small password error")
    }
    
    func testAuthenticatorWithEmptyUsernameAndLargePassword() {
        // given
        let username=""
        let password="password123456789012345"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.username], outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.password, size: 23, max: 15)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect username missing and large password error")
    }
    
    func testAuthenticatorWithEmptyPasswordAndSmallUsername() {
        // given
        let username="us"
        let password=""
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.password], outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.username, size: 2, min: 3)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect small username and password missing error")
    }
    
    func testAuthenticatorWithEmptyPasswordAndLargeUsername() {
        // given
        let username="username12345678"
        let password=""
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(missing: [AuthenticatorError.Field.password], outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.username, size: 16, max: 10)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect large username and password missing error")
    }
    
    func testAuthenticatorWithValidUsernameAndSmallPassword() {
        // given
        let username="username"
        let password="pass"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.password, size: 4, min: 5)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect small password error")
    }
    
    func testAuthenticatorWithValidUsernameAndLargePassword() {
        // given
        let username="username"
        let password="password123456789012345"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.password, size: 23, max: 15)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect large password error")
    }
    
    func testAuthenticatorWithValidPasswordAndSmallUsername() {
        // given
        let username="us"
        let password="password"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.username, size: 2, min: 3)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect small username error")
    }
    
    func testAuthenticatorWithValidPasswordAndLargeUsername() {
        // given
        let username="username12345678"
        let password="password"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.username, size: 16, max: 10)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect large username error")
    }
    
    func testAuthenticatorWithLargeUsernameAndPassword() {
        // given
        let username="username12345678"
        let password="password123456789012"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.username, size: 16, max: 10), AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.password, size: 20, max: 15)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect large username and password error")
    }
    
    func testAuthenticatorWithSmallUsernameAndPassword() {
        // given
        let username="us"
        let password="pass"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.username, size: 2, min: 3), AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.password, size: 4, min: 5)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect small username and password error")
    }
    
    func testAuthenticatorWithLargeUsernameAndSmallPassword() {
        // given
        let username="username12345678"
        let password="pass"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.username, size: 16, max: 10), AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.password, size: 4, min: 5)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect large username and small password error")
    }
    
    func testAuthenticatorWithSmallUsernameAndLargePassword() {
        // given
        let username="us"
        let password="password123456789012"
        let expectedError: Result<Bool, AuthenticatorError> = .failure(AuthenticatorError(outOfBounds: [AuthenticatorError.OutOfBounds.tooSmall(field: AuthenticatorError.Field.username, size: 2, min: 3), AuthenticatorError.OutOfBounds.tooLarge(field: AuthenticatorError.Field.password, size: 20, max: 15)]))

        // when
        let output = sut.authenticate(username: username, password: password)

        // then
        XCTAssertEqual(output, expectedError, "Expect small username and large password error")
    }
}
