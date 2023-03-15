//
//  NutritionixEndpoint.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation

struct NutritionixEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

/// API specific Endpoint extension
extension NutritionixEndpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trackapi.nutritionix.com"
        components.path = "/v2\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    static let defaultHeaders = [
        "Content-Type": "application/json"
    ]
    
    
    static var headers: [String: String] {
        var headers = defaultHeaders
        headers["x-app-id"] = "32c930a8"
        headers["x-app-key"] = "79d0599b813d098e7fcd4e68baf2b40a"
        return headers
    }
}

/// API endpoints
extension NutritionixEndpoint {
    
    static func search(_ query: String) -> Self{
        return NutritionixEndpoint(path: "/search/instant",
                        queryItems: [URLQueryItem(name: "branded", value: "true"),
                                     URLQueryItem(name: "common", value: "true"),
                                     URLQueryItem(name: "query", value: "\(query)"),
                                     URLQueryItem(name: "self", value: "false")])
    }
        
    static var nutrients: Self{
        return NutritionixEndpoint(path: "/natural/nutrients")
    }
    
}

