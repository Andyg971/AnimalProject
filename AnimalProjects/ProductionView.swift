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
                .ignoresSafeArea()

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
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.vertClair, .vertAccent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .annotation(position: .top) {
                        Text(
                            "\(item.amount, format: .number.precision(.fractionLength(1))) \(item.unit)"
                        )
                        .font(.caption2)
                    }

                }
                .chartXAxis {
                    AxisMarks(values: chartData.map(\.period)) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(
                            format: viewMode.dateFormat
                                .locale(Locale(identifier: "fr_FR"))
                        )
                    }
                }
                .frame(height: 250)
                .padding(16)
                Text("Production de \(animal.productionType?.rawValue.lowercased() ?? "")")
                    .font(.system(size: 16, weight: .semibold))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {

                        if !prodList.isEmpty {
                            Grid(verticalSpacing: 12) {
                                GridRow {
                                    Text("Date")
                                        .frame(
                                            minWidth: 100,
                                            alignment: .leading
                                        )
                                    Spacer()
                                    Text("Qté ")
                                        .frame(
                                            minWidth: 48,
                                            alignment: .trailing
                                        )

                                    if prodList.contains(where: {
                                        $0.productionType == .milk
                                    }) {
                                        Text("TB")
                                            .frame(
                                                minWidth: 30,
                                                alignment: .trailing
                                            )
                                        Text("TP")
                                            .frame(
                                                minWidth: 30,
                                                alignment: .trailing
                                            )
                                        Text("Acéto")
                                            .frame(
                                                minWidth: 48,
                                                alignment: .trailing
                                            )
                                    }

                                }
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .font(.system(size: 16, weight: .semibold))

                                ForEach(prodList) { prod in
                                    GridRow {
                                        Text(
                                            prod.date.formatted(
                                                date: .numeric,
                                                time: .omitted
                                            )
                                        ).frame(
                                            minWidth: 92,
                                            alignment: .leading
                                        )
                                        Spacer()
                                        Text(
                                            "\(prod.amount, format: .number.precision(.fractionLength(1))) \(prod.unit)"
                                        ).frame(
                                            minWidth: 48,
                                            alignment: .trailing
                                        )

                                        if let milk = prod as? ProductionMilk {
                                            Text(
                                                "\(milk.tB, format: .number.precision(.fractionLength(1)))"
                                            ).frame(
                                                minWidth: 24,
                                                alignment: .trailing
                                            )
                                            Text(
                                                "\(milk.tP, format: .number.precision(.fractionLength(1)))"
                                            ).frame(
                                                minWidth: 24,
                                                alignment: .trailing
                                            )

                                            if let ketone = milk.ketone {
                                                Text("\(ketone)").frame(
                                                    minWidth: 16
                                                )
                                            } else {
                                                Text("-").frame(
                                                    minWidth: 16
                                                )
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
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
                aniList.sort { $0.date > $1.date }
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
