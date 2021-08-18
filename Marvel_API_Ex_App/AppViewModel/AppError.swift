//
//  AppError.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 28/07/2021.
//

import Foundation
enum AppError: Error, Equatable {
    case badURL(description: String)
    case parsing(description: String)
    case network(description: String)
    
    var description: String{
        switch self {
        case .badURL(let value):
            return value
        case .parsing(let value):
            return value
        case .network(let value):
            return value
        }
    }
}
