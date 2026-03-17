import SwiftUI
import Charts

struct DashboardView: View {
    @State var animalsVM = AnimalsViewModel()
    @State var healthVM = HealthViewModel()
    @State var documentsVM = DocumentsViewModel()
    @State var depenseVM = DepenseViewModel()
    @State var employeeVM = EmployeeViewModel()

    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // Nombre d'animaux
                        HStack(spacing: 8) {
                            Image(systemName: "pawprint.fill")
                                .foregroundStyle(.orange)
                            Text("\(animalsVM.animals.count) animaux sur l'exploitation")
                                .font(.system(size: 15, weight: .medium))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                        .padding(.horizontal, 16)

                        // Cartes cliquables
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10)
                        ], spacing: 10) {
                            NavigationLink(destination: EmployeeView()) {
                                miniCard(value: "\(employeeVM.employees.count)", title: "Employés", icon: "person.2.fill", color: .purple)
                            }
                            .buttonStyle(.plain)
                            NavigationLink(destination: HealthView()) {
                                miniCard(value: "\(healthVM.healthItems.count)", title: "Soins", icon: "cross.case.fill", color: .red)
                            }
                            .buttonStyle(.plain)
                            NavigationLink(destination: DocumentsView()) {
                                miniCard(value: "\(documentsVM.documents.count)", title: "Documents", icon: "doc.text.fill", color: .blue)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 16)

                        // Dépenses (camembert) ( le seul diagramme pour les dépenses en camembert)
                        if !depenseVM.depenses.isEmpty {
                            chartCard(title: "Dépenses par catégorie") {
                                Chart(depensesByCategory, id: \.category) { item in
                                    SectorMark(
                                        angle: .value("Montant", item.total),
                                        innerRadius: .ratio(0.5),
                                        angularInset: 2
                                    )
                                    .foregroundStyle(by: .value("Catégorie", item.category))
                                    .cornerRadius(4)
                                }
                                .chartLegend(position: .bottom, spacing: 10)
                                .frame(height: 300)
                            }
                        }

                        //  Soins (barres)
                        if !healthVM.healthItems.isEmpty {
                            chartCard(title: "Soins par type") {
                                Chart(healthByType, id: \.type) { item in
                                    BarMark(
                                        x: .value("Nombre", item.count),
                                        y: .value("Type", item.type)
                                    )
                                    .foregroundStyle(healthColor(for: item.type))
                                    .cornerRadius(6)
                                    .annotation(position: .trailing) {
                                        Text("\(item.count)")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .chartYAxis {
                                    AxisMarks { _ in
                                        AxisValueLabel()
                                            .font(.system(size: 12))
                                    }
                                }
                                .frame(height: CGFloat(healthByType.count * 50 + 20))
                            }
                        }

                        //  Documents par type (barres)
                        if !documentsVM.documents.isEmpty {
                            chartCard(title: "Documents par type") {
                                Chart(documentsByType, id: \.type) { item in
                                    BarMark(
                                        x: .value("Nombre", item.count),
                                        y: .value("Type", item.type)
                                    )
                                    .foregroundStyle(documentColor(for: item.type))
                                    .cornerRadius(6)
                                    .annotation(position: .trailing) {
                                        Text("\(item.count)")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .chartYAxis {
                                    AxisMarks { _ in
                                        AxisValueLabel()
                                            .font(.system(size: 12))
                                    }
                                }
                                .frame(height: CGFloat(documentsByType.count * 50 + 20))
                            }
                        }

                        //  Animaux par espèce (barres) ( si vous voulez pas des barres je peux changer)
                        if !animalsVM.animals.isEmpty {
                            chartCard(title: "Animaux par espèce") {
                                Chart(animalsBySpecies, id: \.species) { item in
                                    BarMark(
                                        x: .value("Nombre", item.count),
                                        y: .value("Espèce", item.species)
                                    )
                                    .foregroundStyle(animalColor(for: item.species))
                                    .cornerRadius(6)
                                    .annotation(position: .trailing) {
                                        Text("\(item.count)")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .frame(height: CGFloat(animalsBySpecies.count * 50 + 20))
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                    .task {
                        await loadAllData()
                    }
                    .refreshable {
                        await loadAllData()
                    }
                }
                .navigationTitle("Tableau de bord")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // Ca c'est Pour Le Chargement Des Données ( syncronisation)

    func loadAllData() async {
        await animalsVM.getAnimals()
        await employeeVM.fetchEmployees()
        do { try await healthVM.getHealthItems() } catch { print(error) }
        do { try await documentsVM.getDocuments() } catch { print(error) }
        do { try await depenseVM.getDepensess() } catch { print(error) }
    }

    // les Composants

    func miniCard(value: String, title: String, icon: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(color)

            Text(value)
                .font(.system(size: 20, weight: .bold))

            Text(title)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    func chartCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))

            content()
        }
        .padding(16)
        .background(.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        .padding(.horizontal, 16)
    }

    // Voila les Données

    private var depensesByCategory: [(category: String, total: Double)] {
        let grouped = Dictionary(grouping: depenseVM.depenses) { $0.categorie }
        return grouped.map { (category: $0.key, total: $0.value.reduce(0) { $0 + $1.total }) }
            .sorted { $0.total > $1.total }
    }

    private var healthByType: [(type: String, count: Int)] {
        let grouped = Dictionary(grouping: healthVM.healthItems) { $0.type }
        return grouped.map { (type: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
    }

    private var documentsByType: [(type: String, count: Int)] {
        let grouped = Dictionary(grouping: documentsVM.documents) { $0.type.rawValue }
        return grouped.map { (type: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
    }

    private var animalsBySpecies: [(species: String, count: Int)] {
        let grouped = Dictionary(grouping: animalsVM.animals) { $0.species.rawValue }
        return grouped.map { (species: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
    }

    //  Couleurs ( je peux les changés si vous aimez pas)

    private func healthColor(for type: String) -> Color {
        switch type {
        case "Vaccination": return .blue
        case "Vet Visit": return .vertAccent
        case "Health Check": return .orange
        case "Treatment": return .pink
        case "Surgery": return .red
        default: return .gray
        }
    }

    private func animalColor(for species: String) -> Color {
        switch species {
        case "Porcin": return .pink
        case "Bovin": return .brown
        case "Équin": return .black
        case "Caprin": return .gray
        case "Ovin": return .orange
        default: return .blue
        }
    }

    private func documentColor(for type: String) -> Color {
        switch type {
        case "Administratif": return .indigo
        case "Santé": return .red
        case "Production": return .vertAccent
        default: return .gray
        }
    }
}

#Preview {
    DashboardView()
}
