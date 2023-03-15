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
    
    static func symmaryNutritionData(for foods: [FoodEntity]) -> (cal: String, carbohyd: String, protein: String, fat: String){
        var cal = 0.0, carb = 0.0, protein = 0.0, fat = 0.0
        foods.forEach { food in
            cal += food.calories
            carb += food.carbohydrate
            protein += food.protein
            fat += food.fat
        }
        return (cal.toCalories, carb.toWeight, protein.toWeight, fat.toWeight)
    }
}
