//
//  App+Injection.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 28/07/2021.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering{
    public static func registerAllServices() {
        defaultScope = .graph
        //URLSession
        register { URLSession(configuration: .default) }
        
        //Comic
        register { ComicsService()  }.implements( ComicsServiceProtocol.self )
        register { ComicURLComponentsService() }.implements( ComicURLComponentsServiceProtocol.self )
        register { NetworkService() }.implements( NetworkServiceProtocol.self )
        register { ComicViewModel() }
        
        //Character
        register { CharactersService()  }.implements( CharactersServiceProtocol.self )
        register { CharacterURLComponentsService() }.implements( CharacterURLComponentsServiceProtocol.self )
        register { CharacterViewModel() }
    }
}
