//
//  HomeViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    
    @Published var showAddFoodView: Bool = false
    @Published var selectedMealType: MealType = .dinner
    let service = NutritionixService()
    var cancellable = Set<AnyCancellable>()
    
    
    
    func showAddFood(_ type: MealType){
        selectedMealType = type
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.showAddFoodView.toggle()
        }
    }
    
    
    
   
    
    init(){
//        fetch()
//        getNutrient("liquid egg whites")
        
        
    }
    
    
    
    func fetch(){
        service.search("egg")
            .map({$0.branded + $0.common})
            .sink { completion in
                switch completion{
                    
                case .finished: break
                case .failure(let error):
                    print("Error load", error.localizedDescription)
                }
            } receiveValue: { names in
                
                names.forEach { name in
                    print(name)
//                    if let foodName = name.foodName{
//                        self.getNutrient(foodName)
//                    }
                }
                
            }
            .store(in: &cancellable)

    }
    
    
    func getNutrient(_ foodName: String){
        service.getNutrientInfo(for: .init(query: foodName))
            .sink { completion in
                switch completion{
                    
                case .finished: break
                case .failure(let error):
                    print("Error load", error.localizedDescription)
                }
            } receiveValue: { nutrientInfo in
                print(nutrientInfo.foods.first?.foodName ?? "NAN")
            }
            .store(in: &cancellable)
    }
    
}
