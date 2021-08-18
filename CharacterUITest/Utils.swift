//
//  Utils.swift
//  ComicUITests
//
//  Created by Tra Vo on 03/08/2021.
//

import Foundation

struct Utils {
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
}
