//
//  EdamamAPIService.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 22.03.2023.
//

import Foundation
import Alamofire
import Combine


protocol EdamamAPIServiceProtocol: AnyObject{

    func searchRecepies(searchQuery: EdamamSearchQuery) -> AnyPublisher<DataResponse<EdamamSearchRecepiesResult, NetworkError>, Never>
   
}


final class EdamamAPIService: EdamamAPIServiceProtocol{
    

    func searchRecepies(searchQuery: EdamamSearchQuery) -> AnyPublisher<DataResponse<EdamamSearchRecepiesResult, NetworkError>, Never> {
        
        AF.execute(type: EdamamSearchRecepiesResult.self, urlRequest: EdamamRoute.searchRecepies(searchQuery.urlQueryItems))
    }
    
}
