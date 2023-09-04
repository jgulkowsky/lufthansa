//
//  MockDateOfBirthValidator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class MockDateOfBirthValidator: DateOfBirthValidating {
    var shouldThrow = false
    
    func validate(_ dateOfBirth: Date?) throws {
        if shouldThrow {
            throw ValidationError.invalidDateOfBirth(
                message: "invalid date of birth"
            )
        }
    }
}
