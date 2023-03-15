//
//  Helper.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation


class Helper{
    
    
    static func getTotalCall(for foods: [FoodEntity]) -> Double{
        foods.compactMap({$0.calories}).reduce(0, +)
    }
    
    static func getCalloriesForType(for foods: [FoodEntity], type: MealType){
        
    }
}
