//
//  CoreDataManager.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext) {
        self.mainContext = mainContext
    }
    
    func fetchFoods(for date: Date) -> [FoodEntity] {
        let fetchRequest = FoodEntity.fetchForDate(for: date)
    
        do {
            let foods = try mainContext.fetch(fetchRequest)
            return foods
        } catch let error {
            print("Failed to fetch FoodEntity: \(error)")
        }
        return []
    }
    
    func fetchWater(for date: Date) -> WaterEntity?{
        let fetchRequest = WaterEntity.fetchForDate(for: date)
        do {
            let water = try mainContext.fetch(fetchRequest).first
            return water
        } catch let error {
            print("Failed to fetch WaterEntity: \(error)")
        }
        return nil
    }
    
    func removeFood(for food: FoodEntity){
        FoodEntity.delete(food)
    }
    
    func removeWater(for water: WaterEntity){
        WaterEntity.delete(water)
    }
    
    func updateWater(for water: WaterEntity?, value: Double, date: Date){
        WaterEntity.update(water, value: value, context: mainContext, date: date)
    }
    
    func updateFood(for foodEntity: FoodEntity, weight: Double, food: Food, mealType: MealType){
        FoodEntity.update(foodEntity: foodEntity, weight: weight, food: food, mealType: mealType)
    }
    
    func addFood(food: Food, mealType: MealType, weight: Double, userFood: Bool, date: Date){
        FoodEntity.create(for: food, mealType: mealType, weight: weight, userFood: userFood, context: mainContext, date: date)
    }
}
