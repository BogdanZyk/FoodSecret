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
        value.twoNumString
    }
    
    var glassesCoint: Int{
        value.numberOfWaterGlasses
    }
    
    static func fetchForDate(for date: Date) -> NSFetchRequest<WaterEntity> {
        let request = NSFetchRequest<WaterEntity>(entityName: "WaterEntity")
        request.fetchLimit = 1
        let datePredicate = datePredicate(before: date.noon, after: date.dayAfter)
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: true)]
        request.predicate = datePredicate
        return request
    }
    
    static func update(_ item: WaterEntity?, value: Double, context: NSManagedObjectContext, date: Date){
        let water = createIfNeeded(item, context: context, date: date)
        if water.value > 0, value < 0{
            water.value += value
        }else{
            water.value += value
        }
        context.saveContext()
    }
    
    static func createIfNeeded(_ item: WaterEntity?, context: NSManagedObjectContext, date: Date) -> WaterEntity{
        if let item{
            return item
        }else{
            let newWater = WaterEntity(context: context)
            newWater.createAt = date
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
