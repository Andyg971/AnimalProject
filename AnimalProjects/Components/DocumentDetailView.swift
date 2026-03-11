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
                        DetailRowView(
                            title: "Type",
                            value: document.type.rawValue
                        )
                        if let date = document.date {
                            DetailRowView(
                                title: "Date",
                                value: date.formatted(date: .long, time: .omitted)
                            )
                        }
                        if let description = document.description {
                            DetailRowView(
                                title: "Résumé",
                                value: description
                            )
                        }
                    }

                    // Bouton ouvrir le fichier
                    if let file = document.file?.first,
                       let url = URL(string: file.url) {
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
            .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
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
                file: [Attachment(url: "https://example.com/test.pdf", filename: "analyse.pdf")]
            ),
            styleIcon: "flask.fill",
            styleColor: .purple
        )
    }
}
