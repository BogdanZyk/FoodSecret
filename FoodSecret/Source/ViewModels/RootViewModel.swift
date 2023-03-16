//
//  RootViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import CoreData
import Combine

class RootViewModel: ObservableObject{
    
    @Published private(set) var foods = [FoodEntity]()
    @Published private(set) var water: WaterEntity?
    @Published var showAddFoodView: Bool = false
    @Published var selectedMealType: MealType = .dinner
    @Published var selectedDate: Date = .now
    
    private var cancellable = Set<AnyCancellable>()
    private let dataManager: CoreDataManager
    
    init(mainContext: NSManagedObjectContext){
        self.dataManager = CoreDataManager(mainContext: mainContext)
        fetchCoreData()
    }
    

    func showAddFoodView(_ type: MealType){
        selectedMealType = type
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.showAddFoodView.toggle()
        }
    }
}

//MARK: - CRUD Core data actions
extension RootViewModel{
    
    
    func fetchCoreData(){
        fetchFoods()
        fetchWater()
    }
    
    func foodForMeals(_ type: MealType) -> [FoodEntity]{
        foods.filter({$0.mealType == type})
    }
    
    func fetchFoods(){
        foods = dataManager.fetchFoods(for: selectedDate)
    }
    
    func fetchWater(){
        water = dataManager.fetchWater(for: selectedDate)
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
 
    }
    
    func addFood(for food: Food, userFood: Bool, mealType: MealType){
        dataManager.addFood(food: food, mealType: mealType, count: 1, userFood: userFood)
        fetchFoods()
    }
    
}

