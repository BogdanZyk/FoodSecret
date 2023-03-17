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
    
    func updateWater(for water: WaterEntity?, value: Double){
        WaterEntity.update(water, value: value, context: mainContext)
    }
    
    func updateFood(for food: FoodEntity){
        
    }
    
    func addFood(food: Food, mealType: MealType, count: Int16, userFood: Bool){
        FoodEntity.create(for: food, mealType: mealType, count: count, userFood: userFood, context: mainContext)
    }
}
