//
//  Authenticator.swift
//  TestEngineerChallenge-iOS
//
//  Created by Daniel Krofchick on 2021-08-06.
//

struct Authenticator {
    let usernameMin: Int
    let usernameMax: Int
    let passwordMin: Int
    let passwordMax: Int

    init(
        usernameMin: Int = 3,
        usernameMax: Int = 10,
        passwordMin: Int = 5,
        passwordMax: Int = 15
    ) {
        self.usernameMin = usernameMin
        self.usernameMax = usernameMax
        self.passwordMin = passwordMin
        self.passwordMax = passwordMax
    }

    // Bool result is used for .success to allow Equatable comparison, always returns .success(true)
    func authenticate(username: String?, password: String?) -> Result<Bool, AuthenticatorError> {
        var error = AuthenticatorError()

        if
            let username = username,
            !username.isEmpty {
            if username.count < usernameMin {
                error.outOfBounds.append(.tooSmall(field: .username, size: username.count, min: usernameMin))
            }
            if username.count > usernameMax {
                error.outOfBounds.append(.tooLarge(field: .username, size: username.count, max: usernameMax))
            }
        } else {
            error.missing.append(.username)
        }

        if
            let password = password,
            !password.isEmpty {
            if password.count < passwordMin {
                error.outOfBounds.append(.tooSmall(field: .password, size: password.count, min: passwordMin))
            }
            if password.count > passwordMax {
                error.outOfBounds.append(.tooLarge(field: .password, size: password.count, max: passwordMax))
            }
        } else {
            error.missing.append(.password)
        }

        if
            error.missing.isEmpty,
            error.outOfBounds.isEmpty
        {
            return .success(true)
        } else {
            return .failure(error)
        }
    }
}
