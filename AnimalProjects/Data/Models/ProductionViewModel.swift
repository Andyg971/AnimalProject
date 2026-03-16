//
//  ProductionViewModel.swift
//  AnimalProjects
//
//  Created by apprenant79 on 11/03/2026.
//

import Foundation
import Observation

@Observable @MainActor

class ProductionViewModel {
    private let apiKey: String =
        "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Production"
    )!
    var productions: [ProductionData] = []

    func getProductionByID(id: String) async throws -> ProductionData {

        let newURL = URL(
            string:
                "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Production/\(id)"
        )!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            decoder.dateDecodingStrategy = .formatted(formatter)

            let decoded = try decoder.decode(ProductionRecord.self, from: data)
            return convertProduction(decoded)

        } catch {
            print("Échec du décodage: production")
            throw error
        }
    }
}
