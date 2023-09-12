//
//  MockDataProvider.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import Foundation

struct MockDataProvider: DataProviding {
    func saveNewRegisteredUser(_ name: String, _ email: String, _ dateOfBirth: Date) throws {}
}
