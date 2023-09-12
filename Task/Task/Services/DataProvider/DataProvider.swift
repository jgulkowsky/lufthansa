//
//  DataProvider.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import CoreData

struct DataProvider: DataProviding {
    private let viewContext = PersistenceController.shared.viewContext
    
    func getAllRegisteredUsers() -> [RegistrationData] {
        return getRegisteredUsers()
    }
    
    func saveNewRegisteredUser(_ name: String, _ email: String, _ dateOfBirth: Date) throws {
        let alreadyRegisteredUsers = getRegisteredUsers()
        
        guard !alreadyRegisteredUsers.contains(where: { $0.email == email }) else {
            throw DataProvidingError.emailOccupied
        }
        
        let registrationData = RegistrationData(context: viewContext)
        registrationData.name = name
        registrationData.email = email
        registrationData.dateOfBirth = dateOfBirth
        
        save()
    }
}

private extension DataProvider {
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("@jgu: Error in \(#fileID).\(#function)")
        }
    }
    
    func getRegisteredUsers() -> [RegistrationData] {
        do {
            let request = NSFetchRequest<RegistrationData>(entityName: "RegistrationData")
            return try viewContext.fetch(request)
        } catch {
            print("@jgu: Error in \(#fileID).\(#function)")
            return []
        }
    }
}
