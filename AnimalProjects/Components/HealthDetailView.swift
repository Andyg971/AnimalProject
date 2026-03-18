import SwiftUI

struct HealthDetailView: View {
    let item: HealthItem
    let styleIcon: String
    let styleColor: Color

    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {

                    ZStack {
                        Circle()
                            .fill(styleColor.opacity(0.2))
                            .frame(width: 120, height: 120)
                        if let url = item.animalPhoto?.first?.url {
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
                                .foregroundStyle(styleColor)
                        }
                    }
                    .padding(20)

                    // Nom de l'animal
                    if let name = item.animalName?.first {
                        Text(name)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.secondary)
                    }

                    // Titre du soin
                    Text(item.title)
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)

                    
                    VStack(spacing: 12) {
                        EmpDetailRowView(
                            title: "Type",
                            value: item.type.rawValue
                        )
                        EmpDetailRowView(
                            title: "Statut",
                            value: item.status
                        )
//                        if let date = item.date {
                            EmpDetailRowView(
                                title: "Date",
                                value: item.date.formatted(date: .long, time: .omitted)
                            )
//                        }
                        if let nextDate = item.nextDate {
                            EmpDetailRowView(
                                title: "Prochaine date",
                                value: nextDate.formatted(date: .long, time: .omitted)
                            )
                        }
                        if let notes = item.notes {
                            EmpDetailRowView(
                                title: "Notes",
                                value: notes
                            )
                        }
                    }
                }
            }
            .navigationTitle("Détail santé")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HealthDetailView(
            item: HealthItem(
                id: 1,
                title: "Contrôle de santé",
                type: .visiteVeterinaire,
                status: "Scheduled",
                date: Date(),
                nextDate: Date(),
                notes: "Contrôle annuel, état général satisfaisant.",
                animalName: ["Daisy"],
                animalPhoto: []
            ),
            styleIcon: "heart.text.clipboard",
            styleColor: .orange
        )
    }
}
