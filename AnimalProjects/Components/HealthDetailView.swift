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
                    // Photo animal ou icône par défaut a rajouter car la j'ai rien du tous 
                    ZStack {
                        Circle()
                            .fill(styleColor.opacity(0.2))
                            .frame(width: 120, height: 120)
                        // Placeholder en attendant la photo
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(styleColor)
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
                        DetailRowView(
                            title: "Type",
                            value: item.type
                        )
                        DetailRowView(
                            title: "Statut",
                            value: item.status
                        )
//                        if let date = item.date {
                            DetailRowView(
                                title: "Date",
                                value: item.date.formatted(date: .long, time: .omitted)
                            )
//                        }
                        if let nextDate = item.nextDate {
                            DetailRowView(
                                title: "Prochaine date",
                                value: nextDate.formatted(date: .long, time: .omitted)
                            )
                        }
                        if let notes = item.notes {
                            DetailRowView(
                                title: "Notes",
                                value: notes
                            )
                        }
                    }
                }
            }
            .navigationTitle("Détail santé")
            .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    NavigationStack {
        HealthDetailView(
            item: HealthItem(
                id: 1,
                title: "Contrôle de santé",
                type: "Health Check",
                status: "Scheduled",
                date: Date(),
                nextDate: Date(),
                notes: "Contrôle annuel, état général satisfaisant.",
                animalName: ["Daisy"]
            ),
            styleIcon: "heart.text.clipboard",
            styleColor: .orange
        )
    }
}
