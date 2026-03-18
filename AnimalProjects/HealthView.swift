import SwiftUI

struct HealthView: View {
    @State var viewModel = HealthViewModel()
    @State private var search = ""
    var filteredItems: [HealthItem]?
    var animalName: String?
    
    var items: [HealthItem] {
        filteredItems ?? viewModel.healthItems
    }
    
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(items) { item in
                            let style = healthStyle(for: item.type)
                            
                            NavigationLink {
                                HealthDetailView(
                                    item: item,
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
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.primary)
                                        
                                        if let name = item.animalName?.first {
                                            Text(name)
                                                .font(.system(size: 13))
                                                .foregroundStyle(.vertAccent)
                                        }
                                        
                                        Text(item.status)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.secondary)
                                    }
                                    
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
                        if filteredItems == nil {
                            do {
                                try await viewModel.getHealthItems()
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                .navigationTitle(animalName != nil ? "Santé - \(animalName!)" : "Santé")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search, prompt: "Rechercher")
            }
        }
    }
        
        func healthStyle(for type: String) -> (icon: String, color: Color) {
            switch type {
            case "Vaccins":
                return ("syringe.fill", .blue)
            case "Visite Vétérinaire":
                return ("stethoscope", .vertAccent)
            case "Diagnostic":
                return ("heart.text.clipboard", .orange)
            case "Traitement":
                return ("pills.fill", .pink)
            case "Opération":
                return ("scissors", .red)
            case "Maladie":
                return ("allergens.fill", .purple)
            default:
                return ("cross.case.fill", .gray)
            }
        }
    }

#Preview {
    HealthView()
}
