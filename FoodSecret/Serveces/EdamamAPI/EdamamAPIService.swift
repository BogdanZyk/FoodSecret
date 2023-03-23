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

    func searchRecepies(searchQuery: EdamamSearchQuery) -> AnyPublisher<EdamamSearchRecepiesResult, Error>
   
}


final class EdamamAPIService: EdamamAPIServiceProtocol{
    

    let networkManager = NetworkManager.share
    let headers = EdamamEndpoint.defaultHeaders
    
    func searchRecepies(searchQuery: EdamamSearchQuery) -> AnyPublisher<EdamamSearchRecepiesResult, Error> {
        var endpoint = EdamamEndpoint.searchRecepies
        endpoint.queryItems.append(contentsOf: searchQuery.urlQueryItems)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = headers
        return networkManager.execute(type: EdamamSearchRecepiesResult.self, urlRequest: request)
    }
    
}
