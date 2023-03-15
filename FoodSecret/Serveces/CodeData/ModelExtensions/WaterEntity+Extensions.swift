//
//  WaterEntity+Extensions.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation
import CoreData


extension WaterEntity{
    
    
    var friendlyString: String{
        value.friendlyString
    }
    
    var glassesCoint: Int{
        value.numberOfWaterGlasses
    }
    
    static func fetchForDate() -> NSFetchRequest<WaterEntity> {
        let request = NSFetchRequest<WaterEntity>(entityName: "WaterEntity")
        request.fetchLimit = 1
        let datePredicate = datePredicate(before: Date().noon, after: Date.tomorrow)
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: true)]
        request.predicate = datePredicate
        return request
    }
    
    static func update(_ item: WaterEntity?, context: NSManagedObjectContext){
        let water = createIfNeeded(item, context: context)
        water.value += 0.25
        context.saveContext()
    }
    
    static func createIfNeeded(_ item: WaterEntity?, context: NSManagedObjectContext) -> WaterEntity{
        if let item{
            return item
        }else{
            let newWater = WaterEntity(context: context)
            newWater.createAt = Date.now
            newWater.value = 0
            return newWater
        }
    }
    
//    static func withId(_ id: UUID, in context: NSManagedObjectContext) -> WaterEntity{
//        let request = NSFetchRequest<WaterEntity>(entityName: "WaterEntity")
//        request.fetchLimit = 1
//        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
//        if let result = try? context.fetch(request), let water = result.first{
//            return water
//        }else{
//            let newWater = WaterEntity(context: context)
//            newWater.createAt = Date.now
//        }
//    }
    
    static func delete(_ item: WaterEntity){
        if let context = item.managedObjectContext{
            context.delete(item)
            context.saveContext()
        }
    }
}
