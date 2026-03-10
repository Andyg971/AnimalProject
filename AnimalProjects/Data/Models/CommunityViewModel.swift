//
//  CommunityViewModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor

class CommunityViewModel {
    private let apiKey: String =
        "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"

    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/CommunityCategory"
    )!
    var communityCategory: [CommunityCategory] = []

    func getcommunityCategory() async {

        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let decoded = try decoder.decode(CommunityResponse.self, from: data)
            let communityCategory = decoded.records.map{$0.fields}
           
            self.communityCategory = communityCategory
            //                        return animals
        } catch {
            print("Échec du décodage: \(error)")
            //                        throw error
        }
    }
}
