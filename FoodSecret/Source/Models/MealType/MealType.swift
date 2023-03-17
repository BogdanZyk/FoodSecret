//
//  MealType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation

enum MealType: Int16, CaseIterable{
    case breakfast, lunch, dinner, snack
    
    var title: String{
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        case .snack: return "Snack"
        }
    }
    
    var emoji: String{
        switch self {
        case .breakfast: return "☕️"
        case .lunch: return "🍲"
        case .dinner: return "🍝"
        case .snack: return "🍌"
        }
    }
        
    
    func getTotalCallForType(with foods: [FoodEntity]) -> Double{
        foods.filter({$0.mealType == self})
            .compactMap({$0.calories}).reduce(0, +)
    }
    
}
