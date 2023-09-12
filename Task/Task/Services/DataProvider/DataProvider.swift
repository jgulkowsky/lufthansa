//
//  DataProvider.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import CoreData

struct DataProvider: DataProviding {
    private let viewContext = PersistenceController.shared.viewContext
    
    func getRegisteredUsers() throws -> [RegistrationData] {
        let request = NSFetchRequest<RegistrationData>(entityName: "RegistrationData")
        return try viewContext.fetch(request)
    }
    
    func saveNewRegisteredUser(_ name: String, _ email: String, _ dateOfBirth: Date) throws {
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
}
