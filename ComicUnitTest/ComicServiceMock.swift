//
//  ComicServiceMock.swift
//  ComicUnitTests
//
//  Created by Tra Vo on 10/08/2021.
//

import Foundation
@testable import Marvel_API_Ex_App

class ComicServiceMock: ComicsServiceProtocol {
    var apiComicResult : APIComicResult?
    var appError : AppError?
    func fetchComics(completion: @escaping (APIComicResult?, AppError?) -> Void) {
        completion(apiComicResult, appError)
    }
}
