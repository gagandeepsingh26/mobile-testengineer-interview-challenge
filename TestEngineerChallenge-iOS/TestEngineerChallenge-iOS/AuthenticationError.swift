//
//  AuthenticationError.swift
//  TestEngineerChallenge-iOS
//
//  Created by Daniel Krofchick on 2021-08-06.
//

import Foundation

struct AuthenticatorError: Error {
    enum Field {
        case username
        case password

        var string: String  {
            switch self {
            case .username:
                return "username"
            default:
                return "password"
            }
        }

        var missingErrorString: String {
            "Missing \(string)."
        }
    }

    enum OutOfBounds: Equatable, Hashable {
        case tooSmall(field: Field, size: Int, min: Int)
        case tooLarge(field: Field, size: Int, max: Int)

        var errorString: String {
            switch self {
            case .tooSmall(let field, let size, let min):
                return "\(field.string) is too small, currently \(size) characters, minimum is \(min)."
            case .tooLarge(let field, let size, let max):
                return "\(field.string) is too large, currently \(size) characters, maximum is \(max)."
            }
        }
    }

    var missing: [Field] = []
    var outOfBounds: [OutOfBounds] = []

    func errorMessage() -> String? {
        var message = [String]()

        missing.forEach { missing in
            message.append(missing.missingErrorString)
        }

        outOfBounds.forEach { outOfBounds in
            message.append(outOfBounds.errorString)
        }

        return message.isEmpty ? nil : message.joined(separator: " ")
    }
}

extension AuthenticatorError: Equatable {
    // Equality is not dependant on order
    static func == (lhs: AuthenticatorError, rhs: AuthenticatorError) -> Bool {
        Set(lhs.missing) == Set(rhs.missing) && Set(lhs.outOfBounds) == Set(rhs.outOfBounds)
    }
}
