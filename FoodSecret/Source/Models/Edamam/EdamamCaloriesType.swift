//
//  EdamamCaloriesType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamCaloriesType: String, EdamamQueryTypeProtocol{

    
    
    case verySmall = "50-100"
    case small = "100-200"
    case medium = "200-300"
    case hight = "300-400"
    case veryHight = "400-500"
    case large = "500-600"
    case veryLarge = "600-700"
    case fastfood = "700-1000"
    
    var params: [String: String]{
        ["calories": rawValue]
    }
    
    var emoji: String{
        switch self{
            
        case .verySmall: return "🥦"
        case .small: return "🥪"
        case .medium: return "🥐"
        case .hight: return "🌮"
        case .veryHight: return "🍛"
        case .large: return "🥘"
        case .veryLarge: return "🍝"
        case .fastfood: return "🍔"
        }
    }
    
    var typeTitle: String { "Calories type" }

    var title: String{ rawValue.capitalized }
}
