import XCTest

class HomeViewUITests: XCTestCase {

    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testImageExist() {
        let app = XCUIApplication()
        
        let homeImage = app.images["homeImage"] // Assuming the image has this identifier
        
        XCTAssertTrue(homeImage.exists, "The home image should be visible.")
    }
    
    func testButtonsExist() {
        let app = XCUIApplication()
        
        let marvelButton = app.buttons["Ver Heroes de Marvel"]
        let myHeroButton = app.buttons["Ver mis heroes"]
        
        // Then: Ensure the elements exist and are tappable
        XCTAssertTrue(marvelButton.exists, "The 'Ver Heroes de Marvel' button should be visible.")
        XCTAssertTrue(myHeroButton.exists, "The 'Ver mis heroes' button should be visible.")
    }

}
