import Foundation

struct HealthResponse: Codable {
    let records: [HealthRecord]
}

struct HealthRecord: Codable {
    let fields: HealthItem
}

struct HealthItem: Codable, Identifiable {
    var id: Int
    let title: String
    let type: String
    let status: String
    let date: Date?
    let nextDate: Date?
    let notes: String?

    private enum CodingKeys: String, CodingKey {
        case id = "healthID"
        case title, type, status, date, nextDate, notes
    }
}
