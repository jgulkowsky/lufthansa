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
    
    func validate(_ email: String) throws {
        if shouldThrow {
            throw ValidationError.invalidEmail(
                message: messageToThrow
            )
        }
    }
}
