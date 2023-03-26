//
//  FoodEntity+Extension.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation
import UIKit
import CoreData


extension FoodEntity{
    
    var foodNameEditable: String{
        get { foodName ?? ""}
        set { foodName = newValue }
    }
    
    var represCalories: String{
        calories.toCalories
    }
    
    var clamsArray: [String]{
        clams?.words.compactMap({String($0)}) ?? []
    }
    
    var mealType: MealType{
        get { .init(rawValue: mealType_) ?? .breakfast }
        set { mealType_ = newValue.rawValue }
    }
    
    
    var uiImage: UIImage{
        if let image, !image.isEmpty, let uImage = FileManager().retrieveImage(with: image){
            return uImage
        }else{
            return UIImage(systemName: "fork.knife")!
        }
    }

    
    
    static func fetchForDate(for date: Date) -> NSFetchRequest<FoodEntity> {
        let request = NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: true)]
        let datePredicate = datePredicate(before: date.noon, after: date.dayAfter)
        request.predicate = datePredicate
        return request
    }
    
    static func mealPredicate(_ type: MealType) -> NSPredicate{
        NSPredicate(format: "mealType_ = %i", type.rawValue)
    }
    
    static func create(for product: Food,
                       mealType: MealType,
                       weight: Double,
                       userFood: Bool,
                       context: NSManagedObjectContext,
                       date: Date){
        
        let food = FoodEntity(context: context)
        let nutrientData = product.calculeteNutritionData(for: weight)
        food.id = UUID()
        food.foodName = product.freindlyFoodName
        food.fat = nutrientData.fat
        food.protein = nutrientData.protein
        food.carbohydrate = nutrientData.cal
        food.calories = nutrientData.cal
        food.weight = weight
        food.createAt = date
        food.image = product.photo.thumb
        food.mealType = mealType
        food.sugars = nutrientData.sugar
        food.userFood = userFood
        food.clams = product.clamsString
        
        context.saveContext()
    }
    
    static func update(foodEntity: FoodEntity,
                       weight: Double,
                       food: Food,
                       mealType: MealType){
        
        if let context = foodEntity.managedObjectContext{
            let nutrientData = food.calculeteNutritionData(for: weight)
            foodEntity.fat = nutrientData.fat
            foodEntity.protein = nutrientData.protein
            foodEntity.carbohydrate = nutrientData.cal
            foodEntity.calories = nutrientData.cal
            foodEntity.weight = weight
            foodEntity.sugars = nutrientData.sugar
            foodEntity.mealType = mealType
            context.saveContext()
        }
    }
    
    static func delete(_ item: FoodEntity){
        if let context = item.managedObjectContext{
            if item.userFood, let image = item.image{
                FileManager().deleteImage(with: image)
            }
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
