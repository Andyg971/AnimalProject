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
                                            : Color.vertAccent
                                    )
                                    .cornerRadius(12)
                                    .foregroundStyle(
                                        speciesFilter.contains(species)
                                            ? .black : .white
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(
                                                Color.vertAccent.opacity(0.1),
                                                lineWidth: 1
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
                        ForEach(viewModel.animals.filter { animal in
                            speciesFilter.isEmpty || speciesFilter.contains(animal.species)
                        }) { animal in
                            NavigationLink {
                                AnimalDetails(animal: animal)
                            } label: {
                                AnimalRow(animal: animal)
                            }
                            .foregroundColor(.black)
                        }
                    }

                    .task {
                        await viewModel.getAnimals()
                    }

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
