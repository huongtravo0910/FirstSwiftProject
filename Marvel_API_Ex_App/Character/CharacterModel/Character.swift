//
//  Charater.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import Foundation

struct APICharacterResult: Codable{
    var data: APICharacterData
}

struct APICharacterData: Codable{
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String:String]
    var urls: [[String:String]]
}
