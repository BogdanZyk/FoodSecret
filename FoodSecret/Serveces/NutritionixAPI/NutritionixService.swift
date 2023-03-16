//
//  Nut.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation
import Combine


protocol NutritionixServiceProtocol: AnyObject{

    func search(_ query: String) -> AnyPublisher<ProductSearchResult, Error>
    func getNutrientInfo(for params: NutrientParams) -> AnyPublisher<NutrientInfo, Error>
}


final class NutritionixService: NutritionixServiceProtocol{
    

    let networkManager = NetworkManager.share
    let headers = NutritionixEndpoint.headers
    
    func search(_ query: String) -> AnyPublisher<ProductSearchResult, Error> {
        let endpoint = NutritionixEndpoint.search(query)
        print(endpoint.url.absoluteString)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = headers
        return networkManager.execute(type: ProductSearchResult.self, urlRequest: request)
    }
    
    func getNutrientInfo(for params: NutrientParams) -> AnyPublisher<NutrientInfo, Error>{
        
        guard let postData = try? JSONEncoder().encode(params) else {
            print("Error encode NutrientParams")
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        
       
        let endpoint = NutritionixEndpoint.nutrients
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        return networkManager.execute(type: NutrientInfo.self, urlRequest: request)
    }
}
