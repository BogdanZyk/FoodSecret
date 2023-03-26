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

    
    
    var urlQueryItems: [String: String]{
        
        var items: [String: String] = [:]
        
        if !query.isEmpty{
            items["q"] = query
        }
        
        let itemParams = categories.reduce(items) { partialResult, item in
            partialResult.merging(item.params) { (_, new) in new }
        }

        return itemParams
    }
    
   mutating func reset(){
        query = ""
        categories = []
    }
}
