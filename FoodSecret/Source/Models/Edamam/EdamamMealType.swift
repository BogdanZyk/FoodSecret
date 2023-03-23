//
//  EdamamMealType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamMealType: String, CaseIterable{
    
    case breakfast
    case brunch
    case lunchDinner = "lunch/dinner"
    case snack
    case teatime
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "mealType", value: rawValue)
    }
}
