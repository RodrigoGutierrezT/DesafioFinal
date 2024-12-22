//
//  EditMyHeroView.swift
//  DesafioFinal
//
//  Created by Rodrigo on 22-12-24.
//

import SwiftUI
import SwiftData

struct EditMyHeroView: View {
    @Bindable var hero: MyHero
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.start, .end], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                Form {
                    TextField("Nombre",text: $hero.nombre)
                    TextField("Descripción",text: $hero.descripcion)
                    TextField("Habilidad Especial",text: $hero.habilidadEspecial)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Editar Heroe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Listo") {
                        dismiss()
                    } 
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MyHero.self, configurations: config)
        let hero = MyHero(nombre: "test", descripcion: "descripción test", habilidadEspecial: "volar")
        
        return EditMyHeroView(hero: hero)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
