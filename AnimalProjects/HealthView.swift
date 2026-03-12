import SwiftUI

struct HealthView: View {
    @State var viewModel = HealthViewModel()
    @State private var search = ""
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            NavigationStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.healthItems) { item in
                            let style = healthStyle(for: item.type)

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
                    }
                    .padding(.top, 8)
                    .task {
                        do {
                            try await viewModel.getHealthItems()
                        } catch {
                            print(error)
                        }
                    }
                }
                .navigationTitle("Santé")
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .searchable(text: $search, prompt: "Rechercher")
            }
        }
    }

    func healthStyle(for type: String) -> (icon: String, color: Color) {
        switch type {
        case "Vaccination":
            return ("syringe.fill", .blue)
        case "Vet Visit":
            return ("stethoscope", .green)
        case "Health Check":
            return ("heart.text.clipboard", .orange)
        case "Treatment":
            return ("pills.fill", .pink)
        case "Surgery":
            return ("scissors", .red)
        default:
            return ("cross.case.fill", .gray)
        }
    }
}

#Preview {
    HealthView()
}
