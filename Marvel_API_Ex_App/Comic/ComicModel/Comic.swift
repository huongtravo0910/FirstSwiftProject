//
//  Comic.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import Foundation


struct APIComicResult: Codable{
    var data: APIComicData
}

struct APIComicData: Codable{
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable, Equatable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String:String]
    var urls: [[String:String]]
}
