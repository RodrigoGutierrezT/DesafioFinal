import SwiftData
import SwiftUI

struct AddMyHeroView: View {
    @Environment(\.modelContext) var modelContex
    @Environment(\.dismiss) var dismiss
    
    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var habilidadEspecial = ""
    
    var isValidForm: Bool {
        if nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || descripcion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || habilidadEspecial.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.start, .end], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                VStack {
                    Form {
                        Section {
                            TextField("Nombre del Heroe", text: $nombre)
                            TextField("Descripción", text: $descripcion)
                            TextField("Habilidad Especial", text: $habilidadEspecial)
                        }
                        
                        Button("Guardar") {
                            let newHero = MyHero(nombre: nombre, descripcion: descripcion, habilidadEspecial: habilidadEspecial)
                            modelContex.insert(newHero)
                            dismiss()
                        }
                        .disabled(isValidForm == false)
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .scrollContentBackground(.hidden)
                }
                .navigationTitle("Agregar Heroe")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMyHeroView()
    }
}
