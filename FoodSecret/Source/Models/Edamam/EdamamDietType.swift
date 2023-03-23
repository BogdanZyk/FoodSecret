//
//  EdamamDietType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamDietType: String, CaseIterable{
    
    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case highProtein = "High-Protein"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "dietType", value: rawValue.lowercased())
    }
    
}
