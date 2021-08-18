//
//  ComicUnitTests.swift
//  ComicUnitTests
//
//  Created by Tra Vo on 08/08/2021.
//

import XCTest
import Resolver
@testable import Marvel_API_Ex_App

class CharacterUnitTests: XCTestCase {
    
    // MARK: - Properties
    @LazyInjected var networkServiceMock: NetworkServiceMock
    @LazyInjected var characterServiceMock: CharacterServiceMock
    @LazyInjected var mockCharacterURLComponentsService: MockCharacterURLComponentsService
    
    var characterService: CharactersService?
    var characterViewModel: CharacterViewModel?
    
    var mockCharacter: APICharacterResult?
    var appError: AppError?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        //Always place Resolver.registerMockServices() on top for initialization property
        Resolver.registerMockServices()
        characterViewModel = CharacterViewModel()
        characterService = CharactersService()
        
        
        mockCharacter = APICharacterResult(data: APICharacterData(count: 1, results: [Character(id: 0, name: "Character Name", description: "Character description", thumbnail: ["path" : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"], urls: [["url" : "url"]])]))
        appError = AppError.network(description: "Something went wrong! Please try again later.")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testURLComponentSuccessfully() {
        let mockURL = mockCharacterURLComponentsService.makeCharacterComponents(nameStartWith: "a")
        print("aaaaaa \(mockURL.url)")
        let utils = Utils()
        let ts = "abc"
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let expectedURL = URL(string: "http://gateway.marvel.com/v1/public/characters?limit=10&nameStartsWith=a&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)")
        //"https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        let parsedExpectedURL = URLComponents(
            url: expectedURL!,
            resolvingAgainstBaseURL: false
        )!
        XCTAssertTrue( parsedExpectedURL == mockURL )
    }
    
    func testLoadCharactersSuccessfully(){
        //Arrange
        let encodedData = try! JSONEncoder().encode(mockCharacter)
        
        networkServiceMock.result = .success(encodedData)
        //Action
        characterService?.fetchCharaters("mockString"){ data, error in
            //Result
            XCTAssertEqual(data?.data.count, 1)
            XCTAssertEqual(data?.data.results[0].name, "Character Name")
            XCTAssertNil(error)
        }
    }
    
    func testLoadCharactersFailed(){
        //Arrange
        let netwokError = appError!
        networkServiceMock.result = .failure(netwokError)
        //Action
        characterService?.fetchCharaters("mockString"){ data, error in
            //Result
            XCTAssertEqual(netwokError, error)
            XCTAssertNil(data)
            
        }
    }
    
    func testLoadCharacterViewModelSuccessfully(){
        characterServiceMock.appError = nil
        characterServiceMock.apiCharacterResult = self.mockCharacter
        let expectation = self.expectation(description: "Waiting for the characterModel call to complete.")
        characterViewModel?.searchCharacters(characterServiceMock){
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            XCTAssertEqual(self.characterViewModel?.state, .loaded(self.mockCharacter!.data.results))
        }
    }
    
    func testLoadCharacterViewModelFailed(){
        characterServiceMock.apiCharacterResult = nil
        characterServiceMock.appError = self.appError
        let expectation = self.expectation(description: "Waiting for the characterModel call to complete.")
        characterViewModel?.searchCharacters(characterServiceMock){
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertEqual(self.characterViewModel?.state, .failed(self.appError!) )
        }
    }
    
}
