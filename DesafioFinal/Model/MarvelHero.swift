import Foundation


struct MarvelHero: Codable, Identifiable {
    let id: Int
    let nombre: String
    let primeraAparicion: String
    let imagen: String
}

extension MarvelHero {
    var imgUrl: URL {
        URL(string: imagen)!
    }
}
