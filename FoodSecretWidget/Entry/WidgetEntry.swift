//
//  WidgetEntry.swift
//  FoodSecretWidgetExtension
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation
import Intents
import WidgetKit


struct WidgetEntry: TimelineEntry {
    let date: Date
    var totalMacronutrients: Macronutrients?
    var usedMacronutrients: Macronutrients?
    let configuration: ConfigurationIntent
    var water: Water = Water()
    
  static func placeholder() -> Self{
       var entry = WidgetEntry(date: Date(), configuration: ConfigurationIntent())
        entry.usedMacronutrients = .init(callories: 930, fats: 43, proteins: 77, carbs: 120)
        entry.totalMacronutrients = .init(callories: 1500, fats: 60, proteins: 100, carbs: 200)
        entry.water = .init(waterValue: 0.5, numberOfWaterGlasses: 2, maxWaterGlasses: 8)
        
        return entry
    }
}


extension WidgetEntry{
    
    struct Water{
        var waterValue: Double? = 0
        var numberOfWaterGlasses: Int? = 0
        var maxWaterGlasses: Int = 8
    }
    
    struct Macronutrients{
        var callories: Int
        var fats: Int
        var proteins: Int
        var carbs: Int
        
        
        init(_ foods: [FoodEntity]){
            var callories = 0, fats = 0, proteins = 0, carbs = 0
            
            foods.forEach { food in
                callories += Int(food.calories)
                fats += Int(food.fat)
                proteins += Int(food.protein)
                carbs += Int(food.carbohydrate)
            }
            
            self.callories = callories
            self.fats = fats
            self.carbs = carbs
            self.proteins = proteins
        }
        
        
        init(_ halfInfo: UserHalfInfo){
            let data = halfInfo.macronutrientsInGramm
            self.callories = Int(halfInfo.totalCallories)
            self.fats = data.fat
            self.carbs = data.carb
            self.proteins = data.protein
        }
        
        
        init(callories: Int, fats: Int, proteins: Int, carbs: Int){
            self.callories = callories
            self.fats = fats
            self.proteins = proteins
            self.carbs = carbs
        }
    }
}


