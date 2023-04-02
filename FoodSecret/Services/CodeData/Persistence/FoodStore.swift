//
//  FoodStore.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 02.04.2023.
//

import Foundation
import CoreData
import Combine

class FoodStore: NSObject {
    
    var foods = CurrentValueSubject<[FoodEntity], Never>([])
    let context: NSManagedObjectContext
    var frc: NSFetchedResultsController<FoodEntity>?
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        self.frc = nil
    }
    
    func fetch(_ date: Date) {
        let fetchRequest = FoodEntity.fetchForDate(for: date)
        self.frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.frc?.delegate = self
        do {
            try self.frc?.performFetch()
            guard let groups = frc?.fetchedObjects else { return }
            self.foods.value = groups
        } catch {
            print("Failed to fetch objects: \(error)")
        }
    }
}

extension FoodStore: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let categories = controller.fetchedObjects as? [FoodEntity] else {
            return
        }
        self.foods.value = categories
    }
}

