//
//  EmailValidating.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

protocol EmailValidating {
    func validate(_ email: String) throws
}
