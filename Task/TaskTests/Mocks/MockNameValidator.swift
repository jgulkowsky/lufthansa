//
//  MockNameValidator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class MockNameValidator: NameValidating {
    var shouldThrow = false
    var messageToThrow = ""
    var hasValidated = false
    
    func validate(_ name: String) throws {
        hasValidated = true
        if shouldThrow {
            throw ValidationError.invalidName(
                message: messageToThrow
            )
        }
    }
}
