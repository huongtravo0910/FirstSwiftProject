//
//  CharacterUITests.swift
//  CharacterUITests
//
//  Created by Tra Vo on 02/08/2021.
//

import XCTest

class CharacterUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var utils: Utils!
    
    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
        self.utils = Utils()
    }
    
    func testCharacterFlow() throws {
        let welcome = self.app.buttons["welcome_button"]
        welcome.tap()
        XCTAssertEqual(welcome.label, "Welcome to Marvel's World")
        
        let characterTitle = self.app.navigationBars["Marvel"]
        let isCharacterPagePresent = characterTitle.waitForExistence(timeout: 5)
        XCTAssertEqual(isCharacterPagePresent , true)
        
        self.app.textFields.element.tap()
        self.app.textFields.element.typeText("Captain")
        
        
        let characterRow = self.app.staticTexts["character_row"]
        let isCharacterRowPresent = characterRow.waitForExistence(timeout: 10)
        XCTAssertEqual(isCharacterRowPresent, true)
        
        if isCharacterRowPresent {
            let webViewDetailButton = self.app.buttons["go_to_webview_button"].firstMatch
            webViewDetailButton.tap()
            
            sleep(5)
            let detail = self.app.staticTexts["Detail"]
            let exists = NSPredicate(format: "exists == 1")
            expectation(for: exists, evaluatedWith: detail, handler: nil)
            waitForExpectations(timeout: 10, handler: nil)
            
            
            
            XCTAssert(detail.exists)
            
            XCTAssert(app.staticTexts["Detail"].exists)
            
            self.app.swipeUp(velocity: .slow)
            let backToCharacterButton = self.app.buttons["Marvel"]
            backToCharacterButton.tap()
            
            XCTAssertEqual(isCharacterRowPresent, true)
            
            
            let faxPredicate = NSPredicate(format: "label BEGINSWITH 'character'")
            
            let b = self.app.buttons.matching(faxPredicate).element(boundBy: 1)
            print("b.label"+b.label)
            XCTAssertTrue( b.label == "character")
            b.tap()
            backToCharacterButton.tap()
            
            XCTAssertEqual(isCharacterRowPresent, true)
            self.app.textFields.element.tap()
            let randomWord = self.utils.randomString(of: 10)
            
            self.app.textFields.element.typeText(randomWord)
            let notFound = self.app.staticTexts["No character found"]
            let isNotFoundPresent = notFound.waitForExistence(timeout: 5)
            XCTAssertEqual(isNotFoundPresent, true)
        }
        
        
    }
    
}
