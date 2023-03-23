//
//  EdamamSearchQuery.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation


struct EdamamSearchQuery{
    
    var query: String = ""
    var categories: [any EdamamQueryTypeProtocol] = []

    
    
    var urlQueryItems: [URLQueryItem]{
        var items = [URLQueryItem]()
        
        if !query.isEmpty{
            items.append(.init(name: "q", value: query))
        }
        let uRLQueryItems = categories.map { $0.uRLQueryItem }
        items.append(contentsOf: uRLQueryItems)
        return items
    }
    
   mutating func reset(){
        query = ""
        categories = []
    }
}
