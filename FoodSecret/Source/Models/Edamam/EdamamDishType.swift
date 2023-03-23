//
//  EdamamDishType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamDishType: String, CaseIterable{
    
    case biscuitsAndCookies = "biscuits and cookies"
    case bread
    case cereals
    case condimentsAndSauces = "condiments and sauces"
    case desserts
    case drinks
    case egg
    case iceCreamAndCustard = "ice cream and custard"
    case mainCourse = "main course"
    case pancake
    case pasta
    case pastry
    case piesAndTarts = "pies and tarts"
    case pizza
    case preps
    case preserve
    case salad
    case sandwiches
    case seafood
    case sideDish = "side dish"
    case soup
    case specialOccasions = "special occasions"
    case starter
    case sweets
    
    
    var uRLQueryItem: URLQueryItem{
        .init(name: "dishType", value: rawValue)
    }
    
}
