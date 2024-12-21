//
//  MarvelListViewModel.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import Foundation

@Observable
class MarvelListViewModel {
    var heroList: [MarvelHero] = []
    var isLoading: Bool = true
    var errorMessage: String? = nil
    
    private let url = URL(string: "https://heroes-api-two.vercel.app/es/marvel/heroes")!
    
    // Fetch heroes data
    func fetchHeroes() {
        isLoading = true
        errorMessage = nil
        
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
                let decodedHeroes = try JSONDecoder().decode([MarvelHero].self, from: data)
                DispatchQueue.main.async {
                    self.heroList = decodedHeroes
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
