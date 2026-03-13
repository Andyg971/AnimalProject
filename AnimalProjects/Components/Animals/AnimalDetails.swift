//
//  AnimalDetails.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct AnimalDetails: View {
    let animal: Animal
    @State var vmProduction: ProductionViewModel = .init()
    @State var vmHealth: HealthViewModel = .init()
    @State var healthList: [HealthItem] = []
    @State var prodList: [ProductionData] = []
    var prodRows: [InfoRow] {
        prodList.map { prod in
            InfoRow(
                label: prod.date.formatted(date: .numeric, time: .omitted),
                value: "\(prod.amount) \(prod.unit)"
            )
        }
    }
    var healthRows: [InfoRow] {
        healthList.map { health in
            InfoRow(
                label: health.date.formatted(date: .numeric, time: .omitted),
                value: health.title
            )
        }
    }
    var reproRows: [InfoRow] = []
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
            VStack {
                Text(animal.name ?? "")
                    .padding(.top, 32)
                    .font(.system(size: 20, weight: .bold))
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(16)
                
                Text("ID : \(animal.id)")
                    .font(.system(size: 20, weight: .bold))
                Text("\(animal.species.rawValue) (\(animal.race))")
                    .font(.system(size: 16))
                
                HStack {
                    Text("STATUT")
                    Text("AGE")
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        NavigationLink {
                            HealthView()
                        } label: {
                            DetailCard(
                                icon: "cross.case.fill",
                                color: .red,
                                symbol: "",
                                symbolColor: .vertAccent,
                                title: "Santé",
                                infoRows: healthRows.isEmpty
                                ? [
                                    InfoRow(
                                        label: "Aucune donnée de santé",
                                        value: ""
                                    )
                                ] : Array(healthRows.prefix(3))
                            ).foregroundColor(.black)
                        }
                        
                        DetailCard(
                            icon: "microbe.fill",
                            color: .vertAccent,
                            symbol: "",
                            symbolColor: .clear,
                            title: "Reproduction",
                            infoRows: reproRows.isEmpty
                            ? [
                                InfoRow(
                                    label: "Aucune information de reproduction",
                                    value: ""
                                )
                            ]
                            : Array(prodRows.prefix(3))
                        )
                        
                        DetailCard(
                            icon: "chart.bar.xaxis",
                            color: .blue,
                            symbol: animal.productionType?.symbol ?? "",
                            symbolColor: animal.productionType?.color ?? .clear,
                            title: "Production",
                            infoRows: prodRows.isEmpty
                            ? [
                                InfoRow(
                                    label: "Aucune production enregistrée",
                                    value: ""
                                )
                            ]
                            : Array(prodRows.prefix(3))
                        )
                    }
                    .navigationTitle("Détails de l'animal")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            }.task {
                if let animalID = animal.productionIDs {
                    var aniList = [ProductionData]()
                    for id in animalID {
                        
                        do {
                            let result = try await vmProduction.getProductionByID(
                                id: id
                            )
                            aniList.append(result)
                        } catch {
                            print(error)
                        }
                    }
                    prodList = aniList
                }
                
                if let animalID = animal.healthIDs {
                    var aniList = [HealthItem]()
                    for id in animalID {
                        
                        do {
                            let result = try await vmHealth.getHealthByID(id: id)
                            aniList.append(result)
                        } catch {
                            print(error)
                        }
                    }
                    healthList = aniList
                }
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        AnimalDetails(animal: animalTest)
//    }
//}
