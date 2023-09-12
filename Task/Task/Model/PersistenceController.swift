//
//  PersistenceController.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController() // todo: should we use statics?
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
