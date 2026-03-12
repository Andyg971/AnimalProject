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
    @State var prodList: [ProductionData] = []
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
                    if !prodList.isEmpty {

                        ForEach(prodList, id: \.id) { prod in
                            if let prodMilk = prod as? ProductionMilk {
                                Text(prodMilk.tB.description)
                                    .foregroundStyle(Color(.red))
                            } else {
                                Text(prod.unit)
                                    .foregroundStyle(Color(.blue))
                            }
                        }
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
                    //
                    //                    DetailCard(
                    //                        icon: "chart.bar.xaxis",
                    //                        color: .blue,
                    //                        title: "Production",
                    //                        infoRows: animal.productionRows
                    //                    )
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

    }

}

//#Preview {
//    NavigationStack {
//        AnimalDetails(animal: animalTest)
//    }
//}
