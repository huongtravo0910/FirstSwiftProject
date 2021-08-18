//
//  MockCharacterURLComponentsService.swift
//  CharacterUnitTests
//
//  Created by Tra Vo on 18/08/2021.
//

import Foundation
@testable import Marvel_API_Ex_App

final class MockCharacterURLComponentsService: CharacterURLComponentsServiceProtocol {
   
    func makeCharacterComponents(nameStartWith name: String) -> URLComponents {
        let utils = Utils()
        var components = URLComponents()
        let ts = "abc"
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        components.scheme = "http"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/characters"
        
        components.queryItems = [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "nameStartsWith", value: name),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        return components
    }
}

