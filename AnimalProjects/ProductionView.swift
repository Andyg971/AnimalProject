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

    var body: some View {
        let weeklyData = weeklyProduction(from: prodList)
        ZStack {
            Color.grisFond

            VStack {
                Chart(weeklyData, id: \.week) { item in
                    BarMark(
                        x: .value("Semaine", item.week, unit: .weekOfYear),
                        y: .value("Production", item.amount)
                    )
                }
                .frame(height: 250)
                .padding(4)
                
                
                ForEach(prodList) { prod in
                    HStack {
                        Text(prod.date.formatted(date: .numeric, time: .omitted),)
                        Spacer()
                        Text("\(prod.amount, format: .number.precision(.fractionLength(2))) \(prod.unit)")
                        
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
