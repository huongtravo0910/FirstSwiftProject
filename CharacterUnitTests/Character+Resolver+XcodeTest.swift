//
//  Character+Resolver+XcodeTest.swift
//  CharacterUnitTests
//
//  Created by Tra Vo on 18/08/2021.
//

import Resolver
@testable import Marvel_API_Ex_App
extension Resolver {
    // MARK: - Mock Container
    static var mock = Resolver(parent: .main)
    
    // MARK: - Register Mock Services
    static func registerMockServices() {
        root = Resolver.mock
        defaultScope = .application
     
        Resolver.mock.register{NetworkServiceMock()}.implements(NetworkServiceProtocol.self)
        Resolver.mock.register{MockCharacterURLComponentsService()}.implements(CharacterURLComponentsServiceProtocol.self)
        
        Resolver.mock.register{CharactersService()}.implements(CharactersServiceProtocol.self)
        Resolver.mock.register{CharacterServiceMock()}.implements(CharactersServiceProtocol.self)
        Resolver.mock.register{CharacterViewModel()}
    }
}
