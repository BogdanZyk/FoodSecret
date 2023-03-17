//
//  Persistense.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    // Convenience
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    let container: NSPersistentContainer
    let storeURL = AppGroup.gropKey.containerURL.appendingPathComponent("Food.sqlite")
    

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataFoodSecret")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
