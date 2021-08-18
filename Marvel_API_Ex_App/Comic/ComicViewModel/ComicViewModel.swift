//
//  ComicViewModel.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 25/07/2021.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class ComicViewModel: ObservableObject{
    
    @Published var fetchedComics : [Comic] = []
    //    @Published var offset : Int = 0
    @Published private(set) var state: ComicViewModelState = .idle
    @Injected private var comicService: ComicsServiceProtocol
    
    
    func fetchComics(completion: @escaping () -> Void){
        state = .loading
        comicService.fetchComics{ apiResult, error in
            print("comicService")
            //  guard let self = self else { return }
            //            switch result {
            //            case .success(let apiResult):
            //                self.state = .loaded(apiResult.data.results)
            //
            //            case .failure(let error):
            //                self.state = .failed(error)
            
            if let apiResult = apiResult {
                self.state = .loaded(apiResult.data.results)
            } else if let error = error {
                self.state = .failed(error)
            }
            completion()
        }
        
    }
}
