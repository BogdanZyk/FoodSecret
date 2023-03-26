//
//  CoreDataExt.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func saveContext (){
        if self.hasChanges {
            do{
                try self.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//extension NSPredicate {
//    static var all = NSPredicate(format: "TRUEPREDICATE")
//    static var none = NSPredicate(format: "FALSEPREDICATE")
//}
