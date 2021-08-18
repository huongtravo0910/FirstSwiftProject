//
//  ComicURLComponentServiceMock.swift
//  ComicUnitTest
//
//  Created by Tra Vo on 18/08/2021.
//

import Foundation
@testable import Marvel_API_Ex_App


final class MockComicURLComponentsService: ComicURLComponentsServiceProtocol {
    
    func makeComicComponents() -> URLComponents{
        let utils = Utils()
        var components = URLComponents()
        let ts = "abc"
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        // let url = "http://gateway.marvel.com/v1/public/comics?limit=20&offset=0&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
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
