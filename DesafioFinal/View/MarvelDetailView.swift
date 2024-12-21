//
//  MarvelDetailView.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import SwiftUI

struct MarvelDetailView: View {
    let id: Int
    @State private var heroDetail: MarvelHeroDetail? = nil
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    
    private let url: URL
    
    init(id: Int) {
        self.id = id
        self.url = URL(string: "https://heroes-api-two.vercel.app/es/marvel/heroes/\(id)")!
    }
    
    // Fetch hero details based on the id
    func fetchHeroDetails() {
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
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                if isLoading {
                    ProgressView("Loading hero details...")
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if let heroDetail = heroDetail {
                    ScrollView {
                        VStack(alignment: .center) {
                            
                            VStack {
                                
                                // Hero Name
                                Text(heroDetail.nombre)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top, 10)
                                
                                RemoteImage(url: heroDetail.imgUrl, width: 300, height: 300)
                                
                                // Real Name
                                Text("Real Name: \(heroDetail.nombreReal)")
                                    .font(.subheadline)
                                    .padding(.bottom, 20)
                            }
                            
                            Section(header: Text("Descripción").underline()) {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Alias: \(heroDetail.alias.joined(separator: ", "))")
                                        .font(.subheadline)
                                        .padding(.bottom, 10)
                                    
                                    Text("Poderes:")
                                        .font(.subheadline)
                                        .underline()
                                        .padding(.bottom, 10)
                                    
                                    ForEach(heroDetail.poderes, id: \.self) { power in
                                        VStack {
                                            Text(power)
                                                .font(.subheadline)
                                            
                                            Rectangle()
                                                .fill(Color.green)
                                                .frame(height: 4)
                                                .padding(.bottom, 10)

                                        }
                                    }
                                    
                                    // First Appearance
                                    Text("Primera Aparición: \(heroDetail.primeraAparicion)")
                                        .font(.subheadline)
                                        .padding(.bottom, 10)
                                    
                                    // Biography
                                    Text("Biografía: \(heroDetail.historia)")
                                        .font(.subheadline)
                                        .padding(.bottom, 10)
                                    
                                    // Affiliations
                                    Text("afiliaciones: \(heroDetail.afiliaciones.joined(separator: ", "))")
                                        .font(.subheadline)
                                        .padding(.bottom, 10)
                                }
                                .padding(10)
                            }
                        }
                    }
                }
            }
            .onAppear {
                fetchHeroDetails() // Fetch hero details when the view appears
            }
        }
    }
}



#Preview {
    NavigationStack {
        MarvelDetailView(id: 3)
    }
}
