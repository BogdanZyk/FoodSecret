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
    var cancellable = Set<AnyCancellable>()
    
    
    
    func showAddFood(_ type: MealType){
        selectedMealType = type
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.showAddFoodView.toggle()
        }
    }
    
    
}
