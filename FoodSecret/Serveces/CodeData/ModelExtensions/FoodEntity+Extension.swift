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
    
    var represCalories: String{
        calories.toCalories
    }
    
    var represWeight: String{
        weight.toWeight
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
    
    static func create(for product: Food,
                       mealType: MealType,
                       count: Int16,
                       userFood: Bool,
                       context: NSManagedObjectContext){
        
        let food = FoodEntity(context: context)
        food.id = UUID()
        food.foodName = product.foodName ?? "No name"
        food.fat = product.nfSaturatedFat ?? 0
        food.protein = product.nfProtein ?? 0
        food.carbohydrate = product.nfTotalCarbohydrate ?? 0
        food.calories = product.nfCalories ?? 0
        food.weight = Double(product.servingWeightGrams ?? 0)
        food.createAt = Date.now
        food.image = product.photo.thumb
        food.mealType = mealType
        food.userFood = userFood
        food.count = count
        
        context.saveContext()
    }
    
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
