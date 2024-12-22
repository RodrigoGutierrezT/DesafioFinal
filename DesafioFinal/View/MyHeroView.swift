import SwiftUI
import SwiftData

struct MyHeroView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\MyHero.nombre)]) var heroes: [MyHero]
    
    @State private var viewModel = MyHeroViewModel()
    
    init() {
        _viewModel = State(wrappedValue: MyHeroViewModel())
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.start, .end], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                List {
                    ForEach(heroes) { hero in
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(hero.nombre)
                                        .font(.headline)

                                    Text(hero.descripcion)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()

                                VStack(alignment: .leading) {
                                    Text("Habilidad")
                                        .font(.headline)

                                    Text(hero.habilidadEspecial)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Edit") {
                                viewModel.setSelectedHero(hero)
                            }
                            .tint(.blue)

                            Button("Delete", role: .destructive) {
                                viewModel.deleteHero(hero)
                            }
                            .tint(.red)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteHeroes(heroes, at: offsets)
                    }
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [.start, .end]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .listStyle(.plain)
                .background(Color.clear)
            }
            .navigationTitle("Mis Heroes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Hero", systemImage: "plus") {
                        viewModel.toggleAddScreen()
                    }
                }
            }
            .sheet(isPresented: Binding(
                get: { viewModel.selectedHero != nil },
                set: { if !$0 { viewModel.setSelectedHero(nil) } }
            )) {
                if let heroToEdit = viewModel.selectedHero {
                    EditMyHeroView(hero: heroToEdit)
                }
            }
            .sheet(isPresented: $viewModel.showingAddScreen) {
                AddMyHeroView()
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
}

#Preview {
    NavigationStack {
        MyHeroView()
    }
}

