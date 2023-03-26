//
//  EdamamDishType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamDishType: String, EdamamQueryTypeProtocol{
    
    
   
    case desserts
    case drinks
    case egg
    case iceCreamAndCustard = "ice cream"
    case pancake
    case pasta
    case pastry
    case piesAndTarts = "pies"
    case pizza
    case preps
    case preserve
    case salad
    case sandwiches
    case seafood
    case sideDish = "side dish"
    case soup
    case starter
    case sweets
    case biscuitsAndCookies = "cookies"
    case bread
    case condimentsAndSauces = "sauces"
    
    var typeTitle: String { "Dishes type" }

    var title: String { rawValue.capitalized }
    
    var params: [String: String]{
        ["dishType": rawValue]
    }
    
    var emoji: String{
        switch self {
        case .biscuitsAndCookies: return "🍪"
        case .bread: return "🍞"
        case .condimentsAndSauces: return "🥫"
        case .desserts:  return "🍮"
        case .drinks: return "🍸"
        case .egg: return "🥚"
        case .iceCreamAndCustard: return "🍨"
        case .pancake: return "🥞"
        case .pasta: return "🍝"
        case .pastry: return "🥐"
        case .piesAndTarts: return "🥧"
        case .pizza: return "🍕"
        case .preps: return "🥡"
        case .preserve: return "🥕"
        case .salad: return "🥗"
        case .sandwiches: return "🥪"
        case .seafood: return "🍤"
        case .sideDish: return "🧆"
        case .soup: return "🥘"
        case .starter: return "🧃"
        case .sweets: return "🍬"
        }
    }
}
