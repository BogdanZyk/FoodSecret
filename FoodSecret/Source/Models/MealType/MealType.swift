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
    
    var calDistributionPersent: Double{
        switch self {
        case .breakfast: return  0.20
        case .lunch: return 0.35
        case .dinner: return 0.3
        case .snack: return 0.15
        }
    }
        
    
    func getTotalCallForType(with foods: [FoodEntity]) -> Double{
        foods.filter({$0.mealType == self})
            .compactMap({$0.calories}).reduce(0, +)
    }
    
}
