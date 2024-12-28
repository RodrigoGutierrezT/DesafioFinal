import XCTest
@testable import DesafioFinal

class MarvelHeroDetailTests: XCTestCase {

    // MARK: - Test Decoding from JSON

    func testMarvelHeroDetailDecoding() {
        // Given: Sample JSON string for a Marvel hero
        let json = """
        {
            "id": 1,
            "nombre": "Spider-Man",
            "nombreReal": "Peter Parker",
            "alias": ["Spidey", "Web-slinger"],
            "poderes": ["Super strength", "Agility", "Spider-sense"],
            "primeraAparicion": "Amazing Fantasy #15",
            "historia": "Bitten by a radioactive spider, Peter Parker gains spider-like abilities.",
            "afiliaciones": ["Avengers", "Fantastic Four"],
            "imagen": "https://example.com/spiderman.jpg"
        }
        """
        
        // Convert JSON string to Data
        let jsonData = json.data(using: .utf8)!

        // When: Try to decode the JSON data into a MarvelHeroDetail object
        let decoder = JSONDecoder()
        do {
            let heroDetail = try decoder.decode(MarvelHeroDetail.self, from: jsonData)
            
            // Then: Check if the decoding was successful
            XCTAssertEqual(heroDetail.id, 1)
            XCTAssertEqual(heroDetail.nombre, "Spider-Man")
            XCTAssertEqual(heroDetail.nombreReal, "Peter Parker")
            XCTAssertEqual(heroDetail.alias, ["Spidey", "Web-slinger"])
            XCTAssertEqual(heroDetail.poderes, ["Super strength", "Agility", "Spider-sense"])
            XCTAssertEqual(heroDetail.primeraAparicion, "Amazing Fantasy #15")
            XCTAssertEqual(heroDetail.historia, "Bitten by a radioactive spider, Peter Parker gains spider-like abilities.")
            XCTAssertEqual(heroDetail.afiliaciones, ["Avengers", "Fantastic Four"])
            XCTAssertEqual(heroDetail.imagen, "https://example.com/spiderman.jpg")
            
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Test imgUrl property

    func testMarvelHeroDetailImgUrl() {
        // Given: Sample MarvelHeroDetail object
        let heroDetail = MarvelHeroDetail(
            id: 1,
            nombre: "Spider-Man",
            nombreReal: "Peter Parker",
            alias: ["Spidey", "Web-slinger"],
            poderes: ["Super strength", "Agility", "Spider-sense"],
            primeraAparicion: "Amazing Fantasy #15",
            historia: "Bitten by a radioactive spider, Peter Parker gains spider-like abilities.",
            afiliaciones: ["Avengers", "Fantastic Four"],
            imagen: "https://example.com/spiderman.jpg"
        )
        
        // When: Access the imgUrl property
        let imgUrl = heroDetail.imgUrl
        
        // Then: Ensure that the imgUrl is correctly constructed from the `imagen` string
        XCTAssertEqual(imgUrl.absoluteString, "https://example.com/spiderman.jpg")
    }
}

