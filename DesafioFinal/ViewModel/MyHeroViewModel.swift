import SwiftData
import SwiftUI

@Observable
class MyHeroViewModel {
    var showingAddScreen: Bool = false
    var selectedHero: MyHero?

    var modelContext: ModelContext?
    
    // Action to delete selected heroes from the list and model context
    func deleteHeroes(_ heroes: [MyHero], at offsets: IndexSet) {
        guard let modelContext = modelContext else { return }
        
        for offset in offsets {
            let hero = heroes[offset]
            modelContext.delete(hero)
        }
        saveContext()
    }

    // Action to delete a specific hero from the model context
    func deleteHero(_ hero: MyHero) {
        guard let modelContext = modelContext else { return }
        
        modelContext.delete(hero)
        saveContext()
    }

    // Save the context after any changes
    private func saveContext() {
        guard let modelContext = modelContext else { return }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    // Toggle the "Add Hero" screen state
    func toggleAddScreen() {
        showingAddScreen.toggle()
    }

    // Set the selected hero for editing
    func setSelectedHero(_ hero: MyHero?) {
        selectedHero = hero
    }
}

