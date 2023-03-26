//
//  Alamofire+Ext.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 27.03.2023.
//

import Foundation
import Alamofire
import Combine

extension Session{
    
    
    func execute<T: Decodable>(type: T.Type,
                               urlRequest: URLRequestConvertible) ->  AnyPublisher<DataResponse<T, NetworkError>, Never> {
        
        return self.request(urlRequest)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .eraseToAnyPublisher()
    }
    
}
