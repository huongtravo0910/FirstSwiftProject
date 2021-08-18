//
//  CharacterURLComponentsService.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 02/08/2021.
//

import Foundation

protocol CharacterURLComponentsServiceProtocol {
    func makeCharacterComponents(nameStartWith name:String) -> URLComponents
}


struct CharacterURLComponentsService: CharacterURLComponentsServiceProtocol  {
    func makeCharacterComponents(nameStartWith name:String) -> URLComponents {
        let utils = Utils()
        var components = URLComponents()
        let ts = String(Date().timeIntervalSince1970)
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        //"https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
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
