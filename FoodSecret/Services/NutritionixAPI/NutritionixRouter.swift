//
//  NutritionixRouter.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 26.03.2023.
//

import Foundation
import Alamofire

enum NutritionixRouter: URLRequestConvertible
{
    case search(query: String)
    case nutrients(body: NutrientParams)


    static let baseURLString = "https://trackapi.nutritionix.com/v2"

    var method: HTTPMethod{
        switch self {
        case .search:
            return .get
        case .nutrients:
            return .post
        }
     }
    
    
    private var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "x-app-id": NUTRITION_APP_ID,
            "x-app-key": NUTRITION_APP_KEY
        ]
    }

    var path: String {
        switch self {
        case .search:
            return "/search/instant"
        case .nutrients:
            return "/natural/nutrients"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .search(let query):
            return ["branded": "true",
                    "common": "true",
                    "query": "\(query)",
                    "self": "false"]
        case .nutrients:
            return nil
        }
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest
    {
        let url = try NutritionixRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        switch self {
        case .search:
            
            return try URLEncoding.default.encode(urlRequest, with: parameters)
            
        case .nutrients(let body):
            
            let body = try? JSONEncoder().encode(body)
            urlRequest.httpBody = body
            
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
