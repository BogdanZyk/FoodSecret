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
    @Published var showMealsMenu: Bool = false
    @Published var selectedMealType: MealType = .dinner
    @Published var selectedDate: Date = .now
    @Published var curretTab: Tab = .home
    
    var halfInfo: UserHalfInfo{
        UserSettings.HalfInfo.info
    }
    private let foodStore: FoodStore
    private var cancellable = Set<AnyCancellable>()
    private let dataManager: CoreDataManager
    
    init(mainContext: NSManagedObjectContext){
        self.dataManager = CoreDataManager(mainContext: mainContext)
        self.foodStore = FoodStore(context: mainContext)
        
        startFoodSubs()
        fetchCoreData()
    }
    
    var navTitle: String{
        curretTab.getNavTitle(selectedDate.dayDifferenceStr)
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
    
    
    private func startFoodSubs(){
        foodStore.foods
            .sink { foods in
                self.foods = foods
            }
            .store(in: &cancellable)
    }
    
    func fetchCoreData(){
        fetchFoods()
        fetchWater()
    }
    
    func foodForMeals(_ type: MealType) -> [FoodEntity]{
        foods.filter({$0.mealType == type})
    }
    
    func fetchFoods(){
        foodStore.fetch(selectedDate)
    }
    
    func fetchWater(){
        water = dataManager.fetchWater(for: selectedDate)
    }
    
    func removeFood(_ food: FoodEntity){
        dataManager.removeFood(for: food)
    }
    
    
    func updateWater(value: Double){
        dataManager.updateWater(for: water, value: value, date: selectedDate)
        fetchWater()
    }
    
    func updateFood(for foodEntity: FoodEntity, weight: Double, food: Food, mealType: MealType){
        dataManager.updateFood(for: foodEntity, weight: weight, food: food, mealType: mealType)
    }
    
    func addFood(for food: Food, userFood: Bool, weight: Double, mealType: MealType){
        dataManager.addFood(food: food, mealType: mealType, weight: weight, userFood: userFood, date: selectedDate)
    }
    
}


enum Tab: String, CaseIterable{
    
    case home = "Home"
    case recepies = "Recepies"
    case profile = "Profile"
    
    
    var imageName: String{
        switch self {
        case .home: return "house"
        case .recepies: return "book.closed"
        case .profile: return "person.crop.circle"
        }
    }
    
    var fillImageName: String{
        imageName + ".fill"
    }
    
    func getNavTitle(_ title: String) -> String{
        switch self {
        case .home: return title
        case .recepies, .profile: return rawValue
        }
    }
}
