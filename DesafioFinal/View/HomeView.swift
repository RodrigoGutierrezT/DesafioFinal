//
//  HomeView.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.start, .end], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    Image(.home)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                        .accessibilityIdentifier("homeImage")
                    
                    Spacer()
                    
                    CustomButton(label: "Ver Heroes de Marvel", destination: AnyView(MarvelListView()))
                        .accessibilityIdentifier("marvelHeroesButton")
                    
                    CustomButton(label: "Ver mis heroes", destination: AnyView(MyHeroView()))
                        .accessibilityIdentifier("myHeroesButton")
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
