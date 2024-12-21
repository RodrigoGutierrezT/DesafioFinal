//
//  MarvelDetailViewModel.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import Foundation

// ViewModel for MarvelDetailView using the @Observable macro
@Observable
class MarvelDetailViewModel {
    var heroDetail: MarvelHeroDetail? = nil
    var isLoading: Bool = true
    var errorMessage: String? = nil

    private let url: URL

    init(id: Int) {
        self.url = URL(string: "https://heroes-api-two.vercel.app/es/marvel/heroes/\(id)")!
        fetchHeroDetails()
    }

    // Fetch hero details based on the id
    func fetchHeroDetails() {
        self.isLoading = true
        self.errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load data: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    self.isLoading = false
                }
                return
            }

            do {
                let decodedHero = try JSONDecoder().decode(MarvelHeroDetail.self, from: data)
                DispatchQueue.main.async {
                    self.heroDetail = decodedHero
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode data"
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
