//
//  CharacterServiceMock.swift
//  CharacterUnitTests
//
//  Created by Tra Vo on 18/08/2021.
//

import Foundation
@testable import Marvel_API_Ex_App

class CharacterServiceMock: CharactersServiceProtocol {
    var apiCharacterResult : APICharacterResult?
    var appError : AppError?
    func fetchCharaters(_ searchQuery: String, completion: @escaping (APICharacterResult?, AppError?) -> Void) {
        completion(apiCharacterResult,appError)
    }
    
}

