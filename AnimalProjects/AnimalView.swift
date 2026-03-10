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
                            HStack{
                                Image(systemName:"pawprint")
                                    .frame(width:40)
                                VStack(alignment: .leading) {
                                    Text("\(animal.id)")
                                    
                                        .font(.system(size: 20, weight: .bold))
                                    Text("\(animal.species.rawValue) \(animal.race)")
                                        .font(.system(size:16))
                                }
                                Spacer()
                                
                            } .padding(24)
                                .background(LinearGradient(
                                    colors: [
                                        .gray
                                            .opacity(0.1),
                                        .gray
                                            .opacity(0.3),
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing))
                                .cornerRadius(16)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                            
                            
                        }
                        
                    }
                    
                    .task {
                        await viewModel.getAnimals()
                    }
                    
                }
                .navigationTitle("Animaux")
                
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
            
        }
        
    }
}


#Preview {
    AnimalView()
}
