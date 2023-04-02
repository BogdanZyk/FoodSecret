//
//  EdamamRoute.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 27.03.2023.
//

import Foundation
import Alamofire

enum EdamamRoute: URLRequestConvertible
{
    case searchRecepies(Parameters)


    static let baseURLString = "https://api.edamam.com/api"

    var method: HTTPMethod{
        switch self {
        case .searchRecepies:
            return .get
        }
     }
    
    
    private var headers: HTTPHeaders {
         [
            "Accept": "application/json",
            "Accept-Language": "en"
        ]
    }

    var path: String {
        switch self {
        case .searchRecepies:
            return "/recipes/v2"
        }
    }
        
    private var defaultParams: Parameters{
        [
            "app_id": EDAMAM_APP_ID,
            "app_key": EDAMAM_APP_KEY,
            "field": requiredFields,
            "type": "public",
            "random": "true",
            "imageSize": "REGULAR"
        ]
    }
   
    
    private var requiredFields: [String]{
        ["uri", "label", "image", "images", "source", "url", "shareAs", "yield", "dietLabels", "healthLabels", "cautions", "ingredientLines", "ingredients", "calories", "totalWeight", "totalTime", "cuisineType", "mealType", "dishType", "tags"]
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest
    {
        let url = try EdamamRoute.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        let defaultParams: Parameters = defaultParams
        
        switch self {
        case .searchRecepies(let parameters):
            
            let params = defaultParams.merging(parameters) { (_, new) in new }
            
            return try URLEncoding.default.encode(urlRequest, with: params)
        }
      
    }
}



