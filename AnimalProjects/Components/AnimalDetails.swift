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
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.red)
                            Text("Santé".uppercased())
                                .font(Font.system(size: 16, weight: .bold))
                            
                        }
                        .padding(.bottom, 4)
                        
                        HStack {
                            Text("Vaccins")
                            Spacer()
                            Text("À jour")
                                .bold(true)
                        }
                        HStack {
                            Text("Dernier Examen")
                            Spacer()
                            Text("21/02/2026").bold(true)
                        }
                        HStack {
                            Text("Alertes")
                            Spacer()
                            Text("Aucune")
                                .bold(true)
                        }
                    }
                    .frame(height: 100, alignment: .top)
                    .padding(16)
                    .background(LinearGradient(
                        colors: [
                            .gray
                                .opacity(0.1),
                            .gray
                                .opacity(0.2),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "microbe.fill")
                                .foregroundColor(.vertAccent)
                            Text("Reproduction".uppercased())
                                .font(Font.system(size: 16, weight: .bold))
                            
                        }
                        .padding(.bottom, 4)
                        HStack {
                            Text("Insémination")
                            Spacer()
                            Text("Mise bas estimée")
                               
                        }
                        .foregroundColor(.gray)
                        
                    }
                    .frame(height: 100, alignment: .top)
                    .padding(16)
                    .background(LinearGradient(
                        colors: [
                            .gray
                                .opacity(0.1),
                            .gray
                                .opacity(0.2),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "chart.bar.xaxis")
                                .foregroundColor(.blue)
                            Text("Production".uppercased())
                                .font(Font.system(size: 16, weight: .bold))
                            
                        }
                        .padding(.bottom, 4)
                        
                        HStack {
                            Text("Titre d'une info").foregroundColor(.gray)
                            Spacer()
                            Text("Détail de l'info").bold(true)
                        }
                        
                        
                    }
                    .frame(height: 100, alignment: .top)
                    .padding(16)
                    .background(LinearGradient(
                        colors: [
                            .gray
                                .opacity(0.1),
                            .gray
                                .opacity(0.2),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    
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
