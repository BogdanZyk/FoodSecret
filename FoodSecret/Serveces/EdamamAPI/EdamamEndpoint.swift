//
//  EdamamEndpoint.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 22.03.2023.
//

import Foundation

import Foundation

struct EdamamEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

/// API specific Endpoint extension
extension EdamamEndpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/api\(path)"
        components.queryItems = queryItems
        components.queryItems?.append(contentsOf: apiKeys)
        components.queryItems?.append(contentsOf: fields)
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    static let defaultHeaders = [
        "Accept": "application/json",
        "Accept-Language": "en"
    ]
    
    
    private var apiKeys: [URLQueryItem]{
         [
            URLQueryItem(name: "app_id", value: "2d16cbff"),
            URLQueryItem(name: "app_key", value: "7f1d9ee7b324a3b33e3ea506d9ba2110"),
        ]
    }
    
    private var fields: [URLQueryItem]{
        let values = ["uri", "label", "image", "images", "source", "url", "shareAs", "yield", "dietLabels", "healthLabels", "cautions", "ingredientLines", "ingredients", "calories", "totalWeight", "cuisineType", "mealType", "dishType", "tags", "externalID"]
        return values.map({URLQueryItem(name: "field", value: $0)})


    }
}

/// API endpoints
extension EdamamEndpoint {
    
    static var searchRecepies: Self{
        return EdamamEndpoint(path: "/recipes/v2",
                              queryItems: [URLQueryItem(name: "type", value: "public"),
                                           URLQueryItem(name: "random", value: "true"),
                                           URLQueryItem(name: "imageSize", value: "REGULAR")])
    }
}

