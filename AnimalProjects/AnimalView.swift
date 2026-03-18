//
//  AnimalView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import SwiftUI

struct AnimalView: View {
    @State var viewModel = AnimalsViewModel()
    @State private var search = ""
    @State private var speciesFilter: Set<Species> = []
    var filteredAnimals: [Animal] {
        viewModel.animals
            .filter { animal in
                speciesFilter.isEmpty || speciesFilter.contains(animal.species)
            }
            .filter { animal in
                search.isEmpty
                    || (animal.name?.localizedCaseInsensitiveContains(search)
                        ?? false)
                    || animal.race.localizedCaseInsensitiveContains(search)
                    || String(animal.id).contains(search)
            }
            .sorted { $0.id < $1.id }
    }
    var body: some View {

        ZStack {

            Color.grisFond
                .ignoresSafeArea()

            NavigationStack {

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Species.allCases) { species in

                            Button {
                                withAnimation {
                                    if speciesFilter.contains(species) {
                                        speciesFilter.remove(species)
                                    } else {
                                        speciesFilter.insert(species)
                                    }
                                }
                            } label: {
                                Text(species.rawValue)
                                    .frame(width: 64)
                                    .padding(8)
                                    .background(
                                        speciesFilter.contains(species)
                                            ? Color.vertClair.opacity(0.8)
                                            : Color.white
                                    )
                                    .cornerRadius(12)
                                    .foregroundStyle(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                speciesFilter.contains(species)
                                                    ? Color.vertAccent
                                                    : Color.gray.opacity(0.4),
                                                lineWidth: speciesFilter.contains(species) ? 1.5 : 2
                                            )
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }

                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(filteredAnimals) { animal in
                            NavigationLink {
                                AnimalDetails(animal: animal)
                            } label: {
                                AnimalRow(animal: animal)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .task {
                    await viewModel.getAnimals()
                }
                .navigationTitle("Animaux")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search, prompt: "Rechercher un animal")

            }

        }

    }
}

#Preview {
    AnimalView()
}
