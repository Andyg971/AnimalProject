//
//  ProductionView.swift
//  AnimalProjects
//
//  Created by apprenant79 on 16/03/2026.
//

import Charts
import SwiftUI

struct ProductionView: View {

    @State var prodList: [ProductionData] = []
    let animal: Animal
    @State var vmProduction: ProductionViewModel = .init()
    @State var viewMode: ViewMode = .weekly
    var body: some View {

        ZStack {
            Color.grisFond

            VStack {

                let chartData: [AggregatedProduction] = {
                    switch viewMode {
                    case .weekly:
                        return weeklyProduction(from: prodList)
                    case .monthly:
                        return monthlyProduction(from: prodList)
                    }
                }()

                Picker("Vue", selection: $viewMode) {
                    ForEach(ViewMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .tint(.green) //je sais pas pourquoi, mais ça ne marche pas
                .padding(8)
                
                
                Chart(chartData) { item in
                    BarMark(
                        x: .value(
                            viewMode.title,
                            item.period,
                            unit: viewMode.chartUnit
                        ),
                        y: .value("Production", item.amount)
                    )
                    .foregroundStyle(.vertAccent)
                    
                    
                }.frame(height: 250)
                .padding(16)

                ForEach(prodList) { prod in
                    HStack {
                        Text(
                            prod.date.formatted(date: .numeric, time: .omitted),
                        )
                        Spacer()
                        Text(
                            "\(prod.amount, format: .number.precision(.fractionLength(2))) \(prod.unit)"
                        )

                    }
                    .padding(.horizontal, 8)
                    Divider()

                }
            }
        }
        .navigationTitle("Production de \(animal.name ?? "l'animal")")
        .navigationBarTitleDisplayMode(.inline)

        .task {
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
                aniList.sort { $0.date < $1.date }
                prodList = aniList
            }
        }
    }
}
#Preview {
    NavigationStack {
        ProductionView(animal: animalTest)
    }
}
