//
//  AnimalDetails.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI
struct AnimalDetails: View {
    
    let animal: Animal
    var reproRows: [InfoRow] = []
    @State var vmProduction: ProductionViewModel = .init()
    @State var vmHealth: HealthViewModel = .init()
    @State var healthList: [HealthItem] = []
    @State var prodList: [ProductionData] = []
    @State private var isCalendarExpanded = false
    
//Config preperties dans AnimalExtension
    
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            VStack {
                Text(animal.name ?? "")
                    .padding(.top, 32)
                    .font(.system(size: 20, weight: .bold))
                Text("\(animal.species.rawValue) (\(animal.race))")
                    .font(.system(size: 16))
                HStack {
                    ZStack {
                                            Circle()
                                                .fill(Color.vertClair)
                                                .frame(width: 120, height: 120)
                                            if let url = animal.photo?.first?.url {
                                                AsyncImage(url: url) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(width: 120, height: 120)
                                            } else {
                                                Image(systemName: "pawprint.fill")
                                                    .font(.system(size: 48))
                                            }
                                        }
                                        .padding(20)

                    VStack(alignment: .leading) {

                        Text("ID : \(animal.id)")
                            .font(.system(size: 20, weight: .bold))

                        HStack {
                            Text("STATUT :")
                                .font(.system(size: 16, weight: .bold))
                            Text("Inconnu")
                        }
                        HStack {
                            Text("AGE :")
                                .font(.system(size: 16, weight: .bold))
                            Text(age != nil ? "\(age!) ans" : "Inconnu")
                        }
                    }
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Button {
                            withAnimation {
                                isCalendarExpanded.toggle()
                            }
                        } label: {
                            HStack {
                                Image(systemName: "calendar")
                                Text(isCalendarExpanded
                                     ? "Cacher le calendrier" : "Afficher le calendrier")
                                    .font(.system(size: 18, weight: .bold))
                                
                                Spacer()
                                Image(
                                    systemName: isCalendarExpanded
                                        ? "chevron.up" : "chevron.down"
                                )
                            }
                            .padding()
                            .foregroundColor(.vertAccent)
                            .cornerRadius(12)
                        }

                        if isCalendarExpanded {
                            CalendarMonthView(viewModel: vmCalendar)
                                .transition(
                                    .opacity.combined(with: .move(edge: .top))
                                )
                        }
                    }
                    .padding(.horizontal)

                    NavigationLink {
                        HealthView(
                            filteredItems: healthList,
                            animalName: animal.name
                        )
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
                                    label:
                                        "Aucune information de reproduction",
                                    value: ""
                                )
                            ]
                            : Array(reproRows.prefix(3))
                    )
                    NavigationLink {
                        ProductionView(animal: animal)
                    } label: {
                        DetailCard(
                            icon: "chart.bar.xaxis",
                            color: .blue,
                            symbol: animal.productionType?.symbol ?? "",
                            symbolColor: animal.productionType?.color
                                ?? .clear,
                            title: "Production",
                            infoRows: prodRows.isEmpty
                                ? [
                                    InfoRow(
                                        label:
                                            "Aucune production enregistrée",
                                        value: ""
                                    )
                                ]
                                : Array(prodRows.prefix(3))
                        )
                    }.foregroundColor(.black)
                }
                .navigationTitle("Détails de \(animal.name ?? "l'animal")")
                .navigationBarTitleDisplayMode(.inline)
            }

        }.task {
            if let animalID = animal.productionIDs {
                var aniList = [ProductionData]()
                for id in animalID {

                    do {
                        let result =
                            try await vmProduction.getProductionByID(
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
                        let result = try await vmHealth.getHealthByID(
                            id: id
                        )
                        aniList.append(result)
                    } catch {
                        print(error)
                    }
                }
                healthList = aniList
            }
            vmCalendar.events = calendarEvents
        }
    }
}

#Preview {
    NavigationStack {
        AnimalDetails(animal: animalTest)
    }
}
