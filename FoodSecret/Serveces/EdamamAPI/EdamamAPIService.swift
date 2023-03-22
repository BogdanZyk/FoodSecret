//
//  EdamamAPIService.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 22.03.2023.
//

import Foundation

import Foundation
import Combine


protocol EdamamAPIServiceProtocol: AnyObject{

    func searchRecepies(_ query: String?) -> AnyPublisher<EdamamSearchRecepiesResult, Error>
   
}


final class EdamamAPIService: EdamamAPIServiceProtocol{
    

    let networkManager = NetworkManager.share
    let headers = EdamamEndpoint.defaultHeaders
    
    func searchRecepies(_ query: String?) -> AnyPublisher<EdamamSearchRecepiesResult, Error> {
        let endpoint = EdamamEndpoint.searchRecepies(query)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = headers
        return networkManager.execute(type: EdamamSearchRecepiesResult.self, urlRequest: request)
    }
    
}
