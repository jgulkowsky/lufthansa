//
//  MockEmailValidator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class MockEmailValidator: EmailValidating {
    var shouldThrow = false
    var messageToThrow = ""
    var hasValidated = false
    
    func validate(_ email: String) throws {
        hasValidated = true
        if shouldThrow {
            throw ValidationError.invalidEmail(
                message: messageToThrow
            )
        }
    }
}
