import SwiftUI

struct DocumentsView: View {
    @State var viewModel = DocumentsViewModel()
    @State private var search = ""
    
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.documents) { document in
                            let style = documentStyle(for: document.title)
                            
                            NavigationLink {
                                DocumentDetailView(
                                    document: document,
                                    styleIcon: style.icon,
                                    styleColor: style.color
                                )
                            } label: {
                                HStack(spacing: 14) {
                                    Image(systemName: style.icon)
                                        .font(.system(size: 18))
                                        .foregroundStyle(style.color)
                                        .frame(width: 42, height: 42)
                                        .background(style.color.opacity(0.2))
                                        .clipShape(Circle())
                                    
                                    Text(document.title)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.gray)
                                }
                                .padding(16)
                                .background(.white)
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                                .padding(.horizontal, 16)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 8)
                    .task {
                        do {
                            try await viewModel.getDocuments()
                        } catch {
                            print(error)
                        }
                    }
                }
                .navigationTitle("Documents")
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .searchable(text: $search, prompt: "Rechercher un document")
            }
        }
    }
    

    
    func documentStyle(for title: String) -> (icon: String, color: Color) {
        let titre = title.lowercased()
        
        if titre.contains("analyse") || titre.contains("laboratoire") || titre.contains("sang") || titre.contains("lait") {
            return ("flask.fill", .purple)
        }
        if titre.contains("traitement") || titre.contains("médicament") {
            return ("pills.fill", .pink)
        }
        if titre.contains("vétérinaire") || titre.contains("visite") || titre.contains("bilan") {
            return ("stethoscope", .blue)
        }
        if titre.contains("mortalité") || titre.contains("incident") || titre.contains("sanitaire") {
            return ("exclamationmark.triangle.fill", .red)
        }
        if titre.contains("contrat") || titre.contains("achat") {
            return ("signature", .orange)
        }
        if titre.contains("reproduction") || titre.contains("élevage") {
            return ("heart.fill", .mint)
        }
        if titre.contains("alimentation") || titre.contains("ration") {
            return ("leaf.fill", .green)
        }
        if titre.contains("fiscal") || titre.contains("déclaration") || titre.contains("taxe") {
            return ("building.columns.fill", .indigo)
        }
        if titre.contains("transport") || titre.contains("mouvement") {
            return ("truck.box.fill", .brown)
        }
        if titre.contains("identification") || titre.contains("passeport") {
            return ("qrcode", .teal)
        }
        if titre.contains("assurance") {
            return ("shield.checkered", .cyan)
        }
        
        return ("doc.text.fill", .gray)
    }
}

#Preview {
    DocumentsView()
}
