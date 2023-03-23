//
//  EdamamSearchQuery.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation


struct EdamamSearchQuery{
    
    var query: String = ""
    var cuisineType: EdamamCuisineType?
    var dishType: EdamamDishType?
    var mealType: EdamamMealType?
    var dietType: EdamamDietType?
    var healthType: EdamamHealthType?
    
    
    var urlQueryItems: [URLQueryItem]{
        var items = [URLQueryItem]()
        
        if !query.isEmpty{
            items.append(.init(name: "q", value: query))
        }
        if let cuisineType{
            items.append(cuisineType.uRLQueryItem)
        }
        if let dishType{
            items.append(dishType.uRLQueryItem)
        }
        if let dietType{
            items.append(dietType.uRLQueryItem)
        }
        if let mealType{
            items.append(mealType.uRLQueryItem)
        }
        if let healthType{
            items.append(healthType.uRLQueryItem)
        }
        return items
    }
    
   mutating func reset(){
        query = ""
        cuisineType = nil
        dishType = nil
        mealType = nil
        dietType = nil
        healthType = nil
    }
}
