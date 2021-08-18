//
//  CharactersRepo.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 19/07/2021.
//

import Foundation
import SwiftUI
import Combine
import CryptoKit
import Resolver

protocol CharactersServiceProtocol {
    func fetchCharaters(  _ searchQuery: String ,completion: @escaping (APICharacterResult?, AppError?) -> Void)
}

class CharactersService: CharactersServiceProtocol {
    @Injected private var networkService: NetworkService
    @Injected private var characterURLComponentsService: CharacterURLComponentsService
    
    func fetchCharaters(_ searchQuery: String, completion: @escaping (APICharacterResult?, AppError?) -> Void){
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        guard let url = characterURLComponentsService.makeCharacterComponents(nameStartWith: originalQuery).url else {
            return completion(nil, AppError.badURL(description: "The URL is not valid. Please try again later."))
        }
        
        networkService.fetch(with: URLRequest(url:  url)){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    
                    //completion(nil, AppError.parsing(description: "Parsing data failed, please try again later."))
                    do {
                        let characters = try JSONDecoder().decode(APICharacterResult.self, from: data)
                        return completion(characters,nil)
                    } catch{
                        completion(nil, AppError.parsing(description: "Parsing data failed, please try again later."))
                        print("Unexpected error: \(error).")
                    }
                    
                    
                    
                case .failure(let error):
                    return completion(nil, error)
                }
            }
        }
    }
}

//final class CharactersRepo: CharactersRepoProtocol {
//
//    var utils = Utils()
//    func fetchCharaters(  _ searchQuery: String , completion: @escaping (APICharacterResult) -> ()){
//        let ts = String(Date().timeIntervalSince1970)
//        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
//               let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
//               let url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
//               let session = URLSession(configuration: .default)
//
//               session.dataTask(with: URL(string: url)!){
//                   (data, _, err) in
//                   if let error = err{
//                       print(error.localizedDescription)
//                       return
//                   }
//
//                   guard let APIData = data else {
//                       print("no data found")
//                       return
//                   }
//
//                   do {
//                       let characters = try JSONDecoder().decode(APICharacterResult.self, from: APIData)
//                       DispatchQueue.main.async {
//                           completion(characters)
//                       }
//                   }catch{
//                       print(error.localizedDescription)
//                   }
//               }
//               .resume()
//    }
//
//}
