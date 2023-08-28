//
//  EmailValidator.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

struct EmailValidator: EmailValidating {
    private static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2}"
    private static let message = "Email is invalid - domain must contain at least 4 characters: one or more before the dot, at least 1 dot and 2 characters after the dot"
    
    func validate(_ email: String) throws {
        if !isEmailValid(email) {
            throw ValidationError.invalidEmail(message: EmailValidator.message)
        }
    }
}

private extension EmailValidator {
    func isEmailValid(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", EmailValidator.regex)
        return emailPred.evaluate(with: email)
    }
}
