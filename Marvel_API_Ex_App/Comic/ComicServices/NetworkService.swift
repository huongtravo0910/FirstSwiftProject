//
//  NetworkService.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 28/07/2021.
//

import Foundation
import Resolver

// MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func fetch(
        with urlRequest: URLRequest,
        completion: @escaping (Result<Data, AppError>) -> Void
    )
}

// MARK: - NetworkService
class NetworkService {
//    @Injected private var session: URLSession
}

extension NetworkService: NetworkServiceProtocol {
    func fetch(with urlRequest: URLRequest, completion: @escaping (Result<Data, AppError>) -> Void) {
        guard urlRequest.httpMethod == "GET" else {
            completion(.failure(AppError.network(description: "Something went wrong! Please try again later.")))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard
                error == nil,
                let dataContainer = data
            else {
                completion(.failure(AppError.network(description: "Something went wrong! Please try again later.")))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            
            completion(.success(dataContainer))
        }
        .resume()
    }
}
