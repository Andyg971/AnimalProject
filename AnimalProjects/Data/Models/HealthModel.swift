import SwiftUI

struct HealthResponse: Codable {
    let records: [HealthRecord]
}

struct HealthRecord: Codable {
    let fields: HealthItem
}

struct HealthItem: Codable, Identifiable {
    var id: Int
    let title: String
    let type: HealthType
    let status: String
    let date: Date
    let nextDate: Date?
    let notes: String?
    let animalName: [String]?
    let animalPhoto: [Attachment]?
    
    init(id: Int, title: String, type: HealthType, status: String, date: Date, nextDate: Date?, notes: String?, animalName: [String]?, animalPhoto: [Attachment]?) {
        self.id = id
        self.title = title
        self.type = type
        self.status = status
        self.date = date
        self.nextDate = nextDate
        self.notes = notes
        self.animalName = animalName
        self.animalPhoto = animalPhoto
    }

    private enum CodingKeys: String, CodingKey {
        case id = "healthID"
        case title, type, status, date, nextDate, notes
        case animalName = "name (from Lookup)"
        case animalPhoto = "photo (from Lookup)"
        
    }
}

enum HealthType: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case vaccins = "Vaccins"
    case visiteVeterinaire = "Visite Vétérinaire"
    case diagnostic = "Diagnostic"
    case traitement = "Traitement"
    case operation = "Opération"
    case maladie = "Maladie"

    var title: String { rawValue.capitalized }
    var icon: String {
        switch self {
        case .vaccins: "syringe.fill"
        case .visiteVeterinaire: "stethoscope"
        case .diagnostic: "heart.text.clipboard"
        case .traitement: "pills.fill"
        case .operation: "scissors"
        case .maladie: "allergens.fill"
        }
    }
    var color: Color {
        switch self {
        case .vaccins: .blue
        case .visiteVeterinaire: .vertAccent
        case .diagnostic: .orange
        case .traitement: .pink
        case .operation: .red
        case .maladie: .purple
        }
    }

}
