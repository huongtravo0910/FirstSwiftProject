//
//  CharacterViewModelState.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 02/08/2021.
//

enum CharacterViewModelState:  Equatable {
    case idle
    case loading
    case failed(AppError)
    case loaded([Character])
}

