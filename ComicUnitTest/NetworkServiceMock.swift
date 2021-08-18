//
//  NetworkServiceMock.swift
//  ComicUnitTests
//
//  Created by Tra Vo on 10/08/2021.
//

import Foundation
@testable import Marvel_API_Ex_App

class NetworkServiceMock: NetworkServiceProtocol {
    var result: Result<Data, AppError>?
    func fetch(with urlRequest: URLRequest, completion: @escaping (Result<Data, AppError>) -> Void) {
        guard let result = result else {
          fatalError("Result is nil")
        }
        return completion(result)
    }
    
    
}
