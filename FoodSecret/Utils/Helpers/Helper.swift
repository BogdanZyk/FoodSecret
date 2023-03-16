//
//  Helper.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation


class Helper{
    
        
    static func symmaryNutritionData(for foods: [FoodEntity]) -> (cal: Double, carbohyd: Double, protein: Double, fat: Double){
        var cal = 0.0, carb = 0.0, protein = 0.0, fat = 0.0
        foods.forEach { food in
            cal += food.calories
            carb += food.carbohydrate
            protein += food.protein
            fat += food.fat
        }
        return (cal, carb, protein, fat)
    }
    
    static func symmaryNutritionDataString(for foods: [FoodEntity]) -> (cal: String, carbohyd: String, protein: String, fat: String){
        let symmary = symmaryNutritionData(for: foods)
        
        return (symmary.cal.toCalories, symmary.carbohyd.toWeight, symmary.protein.toWeight, symmary.fat.toWeight)
    }
}
