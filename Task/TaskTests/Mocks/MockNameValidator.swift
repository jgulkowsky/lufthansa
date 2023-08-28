//
//  MockNameValidator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class MockNameValidator: NameValidating {
    var shouldThrow = false
    
    func validate(_ name: String) throws {
        if shouldThrow {
            throw ValidationError.invalidName(
                message: "invalid name"
            )
        }
    }
}
