//
//  MarvelHeroDetail.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import Foundation

// MARK: - Hero
struct MarvelHeroDetail: Codable, Identifiable {
    let id: Int
    let nombre: String
    let nombreReal: String
    let alias: [String]
    let poderes: [String]
    let primeraAparicion: String
    let historia: String
    let afiliaciones: [String]
    let imagen: String
}

extension MarvelHeroDetail {
    var imgUrl: URL {
        URL(string: imagen)!
    }
}
