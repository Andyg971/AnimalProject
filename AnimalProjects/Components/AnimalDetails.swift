//
//  AnimalDetails.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct AnimalDetails: View {
    var animal: Animal
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(16)
                    
                    Text("ID : \(animal.id)")
                        .font(.system(size: 20, weight: .bold))
                    Text("\(animal.species.rawValue) \(animal.race)")
                        .font(.system(size: 16))
                    
                    HStack {
                        Text("POIDS")
                        Text("STATUT")
                        Text("AGE")
                    }
                    
                    DetailCard {
                        
                        SectionHeader(
                            icon: "cross.case.fill",
                            color: .red,
                            title: "Santé"
                        )
                        
                        InfoRow(label: "Vaccins", value: "À jour")
                        InfoRow(label: "Dernier Examen", value: "21/02/2026")
                        InfoRow(label: "Alertes", value: "Aucune")
                    }
                    
                    DetailCard {
                        
                        SectionHeader(
                            icon: "microbe.fill",
                            color: .vertAccent,
                            title: "Reproduction"
                        )
                        
                        InfoRow(label: "Insémination", value: "-")
                        InfoRow(label: "Mise bas estimée", value: "-")
                    }
                    
                    DetailCard {
                        
                        SectionHeader(
                            icon: "chart.bar.xaxis",
                            color: .blue,
                            title: "Production"
                        )
                        
                        InfoRow(
                            label: "Titre d'une info",
                            value: "Détail de l'info"
                        )
                    }
                    
                }
                .navigationTitle("Détails de l'animal")
                .toolbarBackground(
                    .vertClair.opacity(0.8),
                    for: .navigationBar
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
        
    }
    
}

#Preview {
    NavigationStack {
        AnimalDetails(animal: animalTest)
    }
}
