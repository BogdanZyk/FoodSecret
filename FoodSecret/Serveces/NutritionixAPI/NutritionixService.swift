//
//  Nut.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation
import Combine
import Alamofire

protocol NutritionixServiceProtocol: AnyObject{

    func getNutrientInfo(for body: NutrientParams) -> AnyPublisher<DataResponse<NutrientInfo, NetworkError>, Never>
    func search(_ query: String) -> AnyPublisher<DataResponse<ProductSearchResult, NetworkError>, Never>
}


final class NutritionixService: NutritionixServiceProtocol{
    
    
    func getNutrientInfo(for body: NutrientParams) -> AnyPublisher<DataResponse<NutrientInfo, NetworkError>, Never>{
        AF.execute(type: NutrientInfo.self, urlRequest: NutritionixRouter.nutrients(body: body))
    }
    
    func search(_ query: String) -> AnyPublisher<DataResponse<ProductSearchResult, NetworkError>, Never>{
        AF.execute(type: ProductSearchResult.self, urlRequest: NutritionixRouter.search(query: query))
    }
}



struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var message: String
}
