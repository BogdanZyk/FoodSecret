//
//  NetworkManager.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation
import Combine


protocol NetworkControllerProtocol: AnyObject {
    
    typealias Headers = [String: Any]
    typealias Params = [String: Any]
    
    func execute<T>(type: T.Type,
                urlRequest: URLRequest
    ) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkManager: NetworkControllerProtocol {

    static let share = NetworkManager()
    
    private init(){}
    
    func execute<T: Decodable>(type: T.Type,
                           urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { try self.handleURLResponse(output: $0, url: urlRequest.url!)}
            .retry(2)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func update(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { try self.handleURLResponse(output: $0, url: urlRequest.url!)}
            .retry(2)
            .eraseToAnyPublisher()
    }
    
}


extension NetworkManager{
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else{
            throw NetworkingError.badURLResponse(url: url, code: response.statusCode)
        }
        return output.data
    }
    
    func handlingCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

enum NetworkingError: LocalizedError{
    case badResponse
    case badURLResponse(url: URL, code: Int?)
    case unknow
    
    var errorDescription: String?{
        switch self {
        case .badURLResponse(let url, let code):
            return "Status code \(code ?? 0), from URL \(url)"
        case .unknow:
            return "Unknow error occured"
        case .badResponse: return "Empty response data"
        }
    }
}
