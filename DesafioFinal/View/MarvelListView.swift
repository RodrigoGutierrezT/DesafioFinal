//
//  MarvelListView.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import SwiftUI

struct MarvelListView: View {
    @State var viewModel = MarvelListViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.end, .start], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando Heroes...")
                } else if let errorMessage = viewModel.errorMessage  {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.heroList) { hero in
                        NavigationLink(destination: MarvelDetailView(id: hero.id)) {
                            HStack {
                                
                                RemoteImage(url: hero.imgUrl, width: 64, height: 128)
                                
                                Spacer()
                                
                                Text(hero.nombre)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                        .listRowBackground(LinearGradient(gradient: Gradient(colors: [.end, .start]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .navigationTitle("Marvel Heroes")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.plain)
                }
            }
            .onAppear {
                viewModel.fetchHeroes()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MarvelListView()
    }
}
