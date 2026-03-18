import SwiftUI

struct DocumentDetailView: View {
    
    let document: Document
    let styleIcon: String
    let styleColor: Color

    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    // Icône du document
                    ZStack {
                        Circle()
                            .fill(styleColor.opacity(0.2))
                            .frame(width: 120, height: 120)
                        Image(systemName: styleIcon)
                            .font(.system(size: 48))
                            .foregroundStyle(styleColor)
                    }
                    .padding(20)

                    // Titre
                    Text(document.title)
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)

                    // Détails
                    VStack(spacing: 12) {
                        EmpDetailRowView(
                            title: "Type",
                            value: document.type.rawValue
                        )
                        if let date = document.date {
                            EmpDetailRowView(
                                title: "Date",
                                value: date.formatted(date: .long, time: .omitted)
                            )
                        }
                        if let description = document.description {
                            EmpDetailRowView(
                                title: "Résumé",
                                value: description
                            )
                        }
                    }

                    // Bouton ouvrir le fichier
                    if let attachment = document.attachment,
                       let url = URL(string: attachment) {
                        Link(destination: url) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.down.doc.fill")
                                Text("Ouvrir le fichier")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.vertAccent)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Détail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

#Preview {
    NavigationStack {
        DocumentDetailView(
            document: Document(
                id: 1,
                title: "Analyse de sang",
                type: .health,
                size: 245_000,
                date: Date(),
                description: "Résultats d'analyse sanguine du troupeau",
                attachment: "https://example.com/test.pdf"
            ),
            styleIcon: "flask.fill",
            styleColor: .purple
        )
    }
}
