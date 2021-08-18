//
//  MD%.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 25/07/2021.
//

import Foundation
import CryptoKit

struct Utils {
    func MD5(data: String) -> String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
}
