//
//  ExploitationViewModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 12/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class DiscussionViewModel {
    private let apiKey: String =
        "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"

    func getDiscussion(_ id: String) async throws -> DiscussionTopic{
        let newURL = URL(string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Discussion/\(id)")!
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

            let decoded = try decoder.decode(DiscussionRecord.self, from: data)
            return decoded.fields
        } catch {
            print("erreur decodage des Discussion")
            throw error
        }
    }
}
