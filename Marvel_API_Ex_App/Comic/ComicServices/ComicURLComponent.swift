//
//  URLComponentsService.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 28/07/2021.
//

import Foundation

protocol ComicURLComponentsServiceProtocol {
    func makeComicComponents() -> URLComponents
}


struct ComicURLComponentsService: ComicURLComponentsServiceProtocol  {
    func makeComicComponents() -> URLComponents {
        let utils = Utils()
        var components = URLComponents()
        let ts = String(Date().timeIntervalSince1970)
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        // let url = "http://gateway.marvel.com/v1/public/comics?limit=10&offset=0&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        components.scheme = "http"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/comics"
        
        components.queryItems = [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        return components
    }
}
