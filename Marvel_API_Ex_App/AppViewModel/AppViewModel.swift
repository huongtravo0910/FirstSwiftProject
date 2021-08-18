//
//  HomeViewModel.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    @Published var comicState: ComicViewModel = ComicViewModel()
    @Published var chacracterState: CharacterViewModel = CharacterViewModel()
}

