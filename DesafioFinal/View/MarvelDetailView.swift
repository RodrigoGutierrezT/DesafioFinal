//
//  MarvelDetailView.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import SwiftUI

struct MarvelDetailView: View {
    let id: Int
    
    @State private var viewModel: MarvelDetailViewModel
    
    init(id: Int) {
        self.id = id
        _viewModel = State(initialValue: MarvelDetailViewModel(id: id))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading hero details...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if let heroDetail = viewModel.heroDetail {
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
        }
    }
}



#Preview {
    NavigationStack {
        MarvelDetailView(id: 3)
    }
}
