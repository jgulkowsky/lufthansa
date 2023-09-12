//
//  DataProvider.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import CoreData

enum DataProvidingError: Error {
    case emailOccupied
}

struct DataProvider: DataProviding {
    private let viewContext = PersistenceController.shared.viewContext
    
    func saveNewRegisteredUser(_ name: String, _ email: String, _ dateOfBirth: Date) throws {
        let alreadyRegisteredUsers = try getRegisteredUsers()
        guard !alreadyRegisteredUsers.contains(where: { $0.email == email }) else {
            throw DataProvidingError.emailOccupied
        }
        
        let registrationData = RegistrationData(context: viewContext)
        registrationData.name = name
        registrationData.email = email
        registrationData.dateOfBirth = dateOfBirth
        try save()
    }
}

private extension DataProvider {
    func save() throws {
        try viewContext.save()
    }
    
    func getRegisteredUsers() throws -> [RegistrationData] {
        let request = NSFetchRequest<RegistrationData>(entityName: "RegistrationData")
        return try viewContext.fetch(request)
    }
}
