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
        guard getRegisteredUsers(withEmail: email).first == nil else {
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
    
    func getRegisteredUsers(
        withName name: String? = nil,
        withEmail email: String? = nil,
        withDateOfBirth dateOfBirth: Date? = nil
    ) -> [RegistrationData] {
        func getRequest() -> NSFetchRequest<RegistrationData> {
            let request = NSFetchRequest<RegistrationData>(entityName: "RegistrationData")
            
            var namePredicate: NSPredicate?
            var emailPredicate: NSPredicate?
            var dateOfBirthPredicate: NSPredicate?
            
            if let name = name {
                namePredicate = NSPredicate(format: "name == %@", name)
            }
            if let email = email {
                emailPredicate = NSPredicate(format: "email == %@", email)
            }
            if let dateOfBirth = dateOfBirth {
                dateOfBirthPredicate = NSPredicate(format: "dateOfBirth == %@", dateOfBirth as NSDate)
            }
            
            let predicates = [namePredicate, emailPredicate, dateOfBirthPredicate].compactMap { $0 }
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
            
            request.predicate = compoundPredicate
            
            return request
        }
        do {
            let request = getRequest()
            return try viewContext.fetch(request)
        } catch {
            print("@jgu: Error in \(#fileID).\(#function)")
            return []
        }
    }
}
