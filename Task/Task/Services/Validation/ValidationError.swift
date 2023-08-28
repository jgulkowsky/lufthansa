//
//  ValidationError.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

enum ValidationError: Error {
    case invalidName(message: String)
    case invalidEmail(message: String)
    case invalidDateOfBirth(message: String)
}
