//
//  ComicUnitTests.swift
//  ComicUnitTests
//
//  Created by Tra Vo on 08/08/2021.
//

import XCTest
import Resolver
@testable import Marvel_API_Ex_App

class ComicUnitTests: XCTestCase {
    
    // MARK: - Properties
    //@LazyInjected var comicURLComponentsServiceMock: ComicURLComponentsServiceMock
    @LazyInjected var networkServiceMock: NetworkServiceMock
    @LazyInjected var comicServiceMock: ComicServiceMock
    @LazyInjected var mockComicURLComponentsService: MockComicURLComponentsService
    
    var comicService: ComicsService?
    var comicViewModel: ComicViewModel?
    
    var appError: AppError?
    var mockComicResult: APIComicResult?
    
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()
        comicViewModel = ComicViewModel()
        comicService = ComicsService()
        
        appError = AppError.network(description: "Something went wrong! Please try again later.")
        mockComicResult = APIComicResult(data: APIComicData(count: 1, results: [Comic(id: 0, title: "Comic Title", description: "Comic description", thumbnail: ["path" : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"], urls: [["url" : "url"]])]))
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testURLComponentSuccessfully() {
        let mockURL = mockComicURLComponentsService.makeComicComponents()
        let utils = Utils()
        let ts = "abc"
        let hash = utils.MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let expectedURL = URL(string: "http://gateway.marvel.com/v1/public/comics?limit=10&offset=0&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)")
        let parsedExpectedURL = URLComponents(
            url: expectedURL!,
            resolvingAgainstBaseURL: false
        )!
        XCTAssertTrue( parsedExpectedURL == mockURL )
    }
    func testLoadComicsSuccessfully(){
        //Arrange
        
        let encodedData = try! JSONEncoder().encode(mockComicResult)
        
        networkServiceMock.result = .success(encodedData)
        //Action
        comicService?.fetchComics{ data, error in
            //Result
            XCTAssertEqual(data?.data.count, 1)
            XCTAssertEqual(data?.data.results[0].title, "Comic Title")
            XCTAssertNil(error)
        }
    }
    
    func testLoadComicsFailed(){
        //Arrange
        let netwokError = AppError.network(description: "Something went wrong!")
        networkServiceMock.result = .failure(netwokError)
        //Action
        comicService?.fetchComics{ data, error in
            //Result
            XCTAssertEqual(netwokError, error)
            XCTAssertNil(data)
            
        }
    }
    
    func testLoadComicViewModelSuccessfully(){
        comicServiceMock.appError = nil
        comicServiceMock.apiComicResult = mockComicResult
        let expectation = self.expectation(description: "Waiting for the comicModel call to complete.")
        comicViewModel?.fetchComics{
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertEqual(self.comicViewModel?.state, .loaded(self.mockComicResult!.data.results))
        }
    }
    
    func testLoadComicViewModelFailed(){
        comicServiceMock.apiComicResult = nil
        comicServiceMock.appError = appError
        let expectation = self.expectation(description: "Waiting for the comicModel call to complete.")
        comicViewModel?.fetchComics{
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            XCTAssertEqual(self.comicViewModel?.state, .failed(self.appError!) )
        }
    }
    
}
