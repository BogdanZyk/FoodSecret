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
    
    static func searchRecepies(_ query: String?) -> Self{
        return EdamamEndpoint(path: "/recipes/v2",
                              queryItems: [URLQueryItem(name: "type", value: "public"),
                                           URLQueryItem(name: "diet", value: "balanced"),
                                           URLQueryItem(name: "health", value: "vegetarian"),
                                           URLQueryItem(name: "cuisineType", value: "British"),
                                           URLQueryItem(name: "mealType", value: "Breakfast"),
                                           URLQueryItem(name: "random", value: "true"),
                                          URLQueryItem(name: "imageSize", value: "REGULAR")])
    }
    
    //    static var nutrients: Self{
//        return EdamamEndpoint(path: "/natural/nutrients")
//    }
    
}

//https://api.edamam.com/api/recipes/v2?type=public&diet=balanced&health=vegetarian&cuisineType=British&mealType=Breakfast&random=true&app_id=4a3e63e1&app_key=3298b52bdf3cb75b62b5f8aabcb2a9a4&field=uri&field=label&field=image&field=images&field=source&field=url&field=shareAs&field=yield&field=dietLabels&field=healthLabels&field=cautions&field=ingredientLines&field=ingredients&field=calories&field=glycemicIndex&field=totalCO2Emissions&field=co2EmissionsClass&field=totalWeight&field=cuisineType&field=mealType&field=dishType&field=instructions&field=tags&field=externalID


//https://api.edamam.com/api/recipes/v2?type=public&app_id=2d16cbff&app_key=7f1d9ee7b324a3b33e3ea506d9ba2110&diet=balanced&health=alcohol-free&cuisineType=British&mealType=Breakfast&imageSize=REGULAR&random=true&field=uri&field=label&field=image&field=images&field=source&field=url&field=shareAs&field=yield&field=dietLabels&field=healthLabels&field=cautions&field=ingredientLines&field=ingredients&field=calories&field=glycemicIndex&field=totalCO2Emissions&field=co2EmissionsClass&field=totalWeight&field=totalTime&field=cuisineType&field=mealType&field=dishType&field=totalNutrients&field=totalDaily&field=digest&field=tags&field=externalId
