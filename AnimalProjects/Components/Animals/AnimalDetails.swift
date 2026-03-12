//
//  AnimalDetails.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct AnimalDetails: View {
    var animal: Animal
    @State var vmProduction: ProductionViewModel = .init()
    @State var vmHealth: HealthViewModel = .init()
    @State var prodList: [ProductionData] = []
    var prodRows: [InfoRow] { prodList.map { prod in
        InfoRow(label: prod.date.formatted(date: .numeric, time: .omitted), value: "\(prod.amount) \(prod.unit)")}}
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
                    
                    //
                    //                    DetailCard(
                    //                        icon: "cross.case.fill",
                    //                        color: .red,
                    //                        title: "Santé",
                    //                        infoRows: healthRows
                    //                    )
                    //
                    //                    DetailCard(
                    //                        icon: "microbe.fill",
                    //                        color: .vertAccent,
                    //                        title: "Reproduction",
                    //                        infoRows: reproductionRows
                    //                    )
                    

                    if !prodList.isEmpty {
                        DetailCard(
                            icon: "chart.bar.xaxis",
                            color: .blue,
                            title: "Production",
                            infoRows: prodRows)
                    } else {
                        DetailCard(
                            icon: "chart.bar.xaxis",
                            color: .blue,
                            title: "Production",
                            infoRows: [InfoRow(label: "Aucune production enregistrée", value: "")])
                            
                                   
//                                   ForEach(prodList, id: \.id) { prod in
//                            if let prodMilk = prod as? ProductionMilk {
//                                
//                                InfoRow(label: prodMilk.date.description, value: "\(prodMilk.amount) L"]
//                            } else {
//                                Text(prod.unit)
//                                    .foregroundStyle(Color(.blue))
//                            }
//                        }
                    }
                }
                .navigationTitle("Détails de l'animal")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            
        }.task {
            if let animalID = animal.productionIDs {
                var aniList = [ProductionData]()
                for id in animalID {

                    do {
                       let result = try await vmProduction.getProductionByID(id: id)
                        aniList.append(result)
                    } catch {
                        print(error)
                    }
                }
                prodList = aniList
            }
        }
        
//        .task {
//            if let animalID = animal.healthIDs {
//                var aniList = [HealthItem]()
//                for id in animalID {
//
//                    do {
//                       let result = try await vmHealth.getHealthByID(id: id)
//                        aniList.append(result)
//                    } catch {
//                        print(error)
//                    }
//                }
//                prodList = aniList
//            }
//        }
    }

}

//#Preview {
//    NavigationStack {
//        AnimalDetails(animal: animalTest)
//    }
//}
