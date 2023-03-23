//
//  EdamamDietType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamDietType: String, EdamamQueryTypeProtocol{
   
    
    
    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case highProtein = "High-Protein"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "dietType", value: rawValue.lowercased())
    }
    
    var emoji: String{
        
        switch self{
            
        case .balanced: return "⚖️"
        case .highFiber: return "🍠"
        case .highProtein: return "🍗"
        case .lowCarb: return "🥜"
        case .lowFat: return "🥦"
        case .lowSodium: return "🫙"
        }
    }
    
    var title: String { rawValue.capitalized }
}
