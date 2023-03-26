//
//  EdamamCuisineType.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

enum EdamamCuisineType: String, EdamamQueryTypeProtocol{
    
    case american, asian, british, caribbean, central, europe, chinese, eastern, french, greek, indian, italian, japanese, korean, kosher, mediterranean, mexican, middle, nordic, south, east, world
    
    var params: [String: String]{
        ["cuisineType": rawValue]
    }
    
    var title: String { rawValue.capitalized }
    var typeTitle: String { "Cuisines type" }
    
    var emoji: String {
        return ""
    }
}

