//
//  AnimalView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import SwiftUI

struct AnimalView: View {
    @State var viewModel = AnimalsViewModel()
    var body: some View {
        
        ZStack {
            
            Color.grisFond
                .ignoresSafeArea()
            
            NavigationStack {
                
                ScrollView(showsIndicators: false) {
                    LazyVStack() {
                        ForEach(viewModel.animals) { animal in
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
            }
            
        }
        
    }
}


#Preview {
    AnimalView()
}
