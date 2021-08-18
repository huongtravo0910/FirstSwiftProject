//
//  ComicViewModelState.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 28/07/2021.
//

enum ComicViewModelState:  Equatable {
    case idle
    case loading
    case failed(AppError)
    case loaded([Comic])
}
