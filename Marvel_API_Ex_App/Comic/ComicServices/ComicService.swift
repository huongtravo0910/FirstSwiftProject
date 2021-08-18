//
//  ComicsRepo.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 19/07/2021.
//

import Foundation
import SwiftUI
import Combine
import Resolver

protocol ComicsServiceProtocol {
    func fetchComics(completion: @escaping (APIComicResult?, AppError?) -> Void)
}

class ComicsService: ComicsServiceProtocol {
    @Injected private var networkService: NetworkService
    @Injected private var comicURLComponentsService: ComicURLComponentsService
    
    func fetchComics(completion: @escaping (APIComicResult?, AppError?) -> Void){
        
        guard let url = comicURLComponentsService.makeComicComponents().url else {
            return completion(nil, AppError.badURL(description: "The URL is not valid. Please try again later."))
        }
        
        networkService.fetch(with: URLRequest(url:  url)){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    
                    //completion(nil, AppError.parsing(description: "Parsing data failed, please try again later."))
                    do {
                        let comics = try JSONDecoder().decode(APIComicResult.self, from: data)
                        return completion(comics, nil)
                    } catch{
                        completion(nil,AppError.network(description: "Something went wrong! Please try again later."))
                        print("Unexpected error: \(error).")
                    }
                    
                    
                    
                case .failure(let error):
                    return completion(nil, error)
                }
            }
        }
    }
}

