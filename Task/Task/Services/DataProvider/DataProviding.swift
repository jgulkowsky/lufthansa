//
//  DataProviding.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import Foundation

protocol DataProviding {
    func getRegisteredUsers() throws -> [RegistrationData]
    func saveNewRegisteredUser(_ name: String, _ email: String, _ dateOfBirth: Date) throws
}
