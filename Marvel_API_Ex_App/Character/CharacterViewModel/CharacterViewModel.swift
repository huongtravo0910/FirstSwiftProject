//
//  CharacterViewModel.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 25/07/2021.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class CharacterViewModel: ObservableObject{
    
    @Published var fetchedCharacters : [Character]? = []
    @Published var searchQuery = ""
    //    @Published var offset : Int = 0
    @Published private(set) var state: CharacterViewModelState = .idle
    @Injected private var characterService: CharactersServiceProtocol
    private var searchCancellable: AnyCancellable? = nil
    init() {
        searchCancellable = $searchQuery.removeDuplicates().debounce(for: 0.6, scheduler: RunLoop.main).sink(receiveValue:{
            str in
            if str == "" {
                //reset Data
                self.fetchedCharacters = nil
            }else {
                //search Data
                self.searchCharacters(self.characterService){}
            }
        })
    }
    
    
    func searchCharacters(_ characterService: CharactersServiceProtocol, completion: @escaping () -> Void){
        state = .loading
        characterService.fetchCharaters(searchQuery){
            apiResult, error in
            print("characterService")
            //   guard let self = self else { return }
            if let apiResult = apiResult {
                self.state = .loaded(apiResult.data.results)
                print("Data \(self.state)")
            } else if let error = error {
                self.state = .failed(error)
            }
            completion()
        }
        
    }
}
