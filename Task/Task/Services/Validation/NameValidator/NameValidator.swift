//
//  NameValidator.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

struct NameValidator: NameValidating {
    private static let message = "Name should contain at least 1 non-whitespace character"
    
    func validate(_ name: String) throws {
        if !isNameValid(name) {
            throw ValidationError.invalidName(message: NameValidator.message)
        }
    }
}

private extension NameValidator {
    func isNameValid(_ name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
