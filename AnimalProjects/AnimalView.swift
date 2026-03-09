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
        
        
        VStack() {
            List(viewModel.animals, id: \.idNumber) { animal in
                Text("\(animal.idNumber)")
            }
        }
        .task {
            await viewModel.getAnimals()
        }
    }
}

#Preview {
    AnimalView()
}
