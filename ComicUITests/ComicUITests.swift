//
//  ComicUITests.swift
//  ComicUITests
//
//  Created by Tra Vo on 02/08/2021.
//

import XCTest

class ComicUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func testComicsFlow() throws {
        let welcome = self.app.buttons["welcome_button"]
        welcome.tap()
        
        XCTAssertEqual(welcome.label, "Welcome to Marvel's World")
        let comic = self.app.buttons["Com"]
        comic.tap()
        
        let characterTitle = self.app.navigationBars["Marvel"]
        let isCharacterPagePresent = characterTitle.waitForExistence(timeout: 2)
        XCTAssertEqual(isCharacterPagePresent , true)
        
        comic.tap()
        let comicTitle = self.app.navigationBars["Marvel's Comics"]
        let isComicPagePresent = comicTitle.waitForExistence(timeout: 5)
        if(!isComicPagePresent){
            comic.tap()
        }
        
        let isComicPageFound = comicTitle.waitForExistence(timeout: 5)
        XCTAssertEqual(isComicPageFound, true)
        
        let comicRow = self.app.staticTexts["comic row"]
        XCTAssertTrue(comicRow.exists)
    }
}

