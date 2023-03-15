//
//  FoodEntity+Extension.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation
import CoreData


extension FoodEntity{
    
    var foodNameEditable: String{
        get { foodName ?? ""}
        set { foodName = newValue }
    }
    
    var mealType: MealType{
        get { .init(rawValue: mealType_) ?? .breakfast }
        set { mealType_ = newValue.rawValue }
    }
    
    static func fetchForDate() -> NSFetchRequest<FoodEntity> {
        let request = NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: true)]
        let datePredicate = datePredicate(before: Date().noon, after: Date.tomorrow)
        request.predicate = datePredicate
        return request
    }
    
    static func mealPredicate(_ type: MealType) -> NSPredicate{
        NSPredicate(format: "mealType_ = %i", type.rawValue)
    }
    
    
//    static func update(food: FoodEntity, name: String, context: NSManagedObjectContext){
//        food.foodName = name
//        context.saveContext()
//    }
    
    
//    static func withId(_ id: UUID, in context: NSManagedObjectContext) -> FoodEntity?{
//        let request = NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
//        request.fetchLimit = 1
//        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
//        let result = try? context.fetch(request)
//
//        return result?.first
//    }
    
    static func delete(_ item: FoodEntity){
        if let context = item.managedObjectContext{
            context.delete(item)
            context.saveContext()
        }
    }
    
    static func delete(at offsets: IndexSet, for items: [FoodEntity]) {
        if let first = items.first, let context = first.managedObjectContext {
            offsets.map { items[$0] }.forEach(context.delete)
            context.saveContext()
        }
    }
}


func datePredicate(before: Date, after: Date)-> NSPredicate? {
    NSPredicate(format: "createAt >= %@ AND createAt < %@", before as NSDate, after as NSDate)
}
