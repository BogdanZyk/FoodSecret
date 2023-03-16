//
//  RootViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import CoreData

class RootViewModel: ObservableObject{
    
    
    @Published private(set) var foods = [FoodEntity]()
    @Published private(set) var water: WaterEntity?
    
    private let dataManager: CoreDataManager
    
    init(mainContext: NSManagedObjectContext){
        self.dataManager = CoreDataManager(mainContext: mainContext)
        fetchFoods()
        fetchWater()
    }
    
    func foodForMeals(_ type: MealType) -> [FoodEntity]{
        foods.filter({$0.mealType == type})
    }
    
    func fetchFoods(){
        foods = dataManager.fetchFoodsForDate()
    }
    
    func fetchWater(){
        water = dataManager.fetchWaterForDate()
    }
    
    func removeFood(_ food: FoodEntity){
        dataManager.removeFood(for: food)
        fetchFoods()
    }
    
    
    func updateWater(){
        dataManager.updateWater(for: water)
        fetchWater()
    }
    
    func updateFood(for food: FoodEntity){
       // dataManager.
    }

    func createFood(){
        dataManager.createFood()
        fetchFoods()
    }
}


struct CoreDataManager {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext) {
        self.mainContext = mainContext
    }
    
    func fetchFoodsForDate() -> [FoodEntity] {
        let fetchRequest = FoodEntity.fetchForDate()
    
        do {
            let foods = try mainContext.fetch(fetchRequest)
            return foods
        } catch let error {
            print("Failed to fetch FoodEntity: \(error)")
        }
        return []
    }
    
    func fetchWaterForDate() -> WaterEntity?{
        let fetchRequest = WaterEntity.fetchForDate()
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
    
    func updateWater(for water: WaterEntity?){
        WaterEntity.update(water, context: mainContext)
    }
    
    func updateFood(for food: FoodEntity){
        
    }
    
    func createFood(){
        let newItem = FoodEntity(context: mainContext)
        newItem.id = UUID()
        newItem.foodName = "Eggs \(Int.random(in: 1...1000))"
        newItem.createAt = Date.now
        newItem.calories = 125.5
        newItem.mealType = .init(rawValue: Int16.random(in: 0...3)) ?? .breakfast
        mainContext.saveContext()
    }
}
