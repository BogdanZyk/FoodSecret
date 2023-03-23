//
//  EdamamMealType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamMealType: String, EdamamQueryTypeProtocol{
    
    case breakfast
    case brunch
    case dinner = "lunch/dinner"
    case snack

    var title: String { rawValue.capitalized }
    var typeTitle: String { "Meals type" }
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "mealType", value: rawValue)
    }
    
    
    var emoji: String{
        switch self {
        case .breakfast: return "☕️"
        case .brunch: return "🍲"
        case .dinner: return "🍝"
        case .snack: return "🍌"
        }
    }
}
