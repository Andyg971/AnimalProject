//
//  ModelsAPI.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Foundation
import Observation

@Observable @MainActor

class AnimalsViewModel {
    private let apiKey: String =
        "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Animals"
    )!

    var animals: [Animal] = []

    func getAnimals() async {

        var request = URLRequest(url: baseURL)
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

            let decoded = try decoder.decode(AnimalsResponse.self, from: data)
            let animals = decoded.records.map { $0.fields }
            let sortedAnimal = animals.sorted { $0.id < $1.id }
            self.animals = sortedAnimal
            
        } catch {
            print("Échec du décodage: \(error)")
        }
    }

    

}
//import Foundation
//import Observation
//
//@Observable @MainActor
//class AnimalsViewModel {
//    private let apiKey = "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"
//    private let baseAnimalsURL = URL(string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Animals")!
//    private let baseProductionsURL = URL(string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Production")!
//
//    var animals: [Animal] = []
//
//    func getAnimals() async {
//        do {
//            let animalsRecords = try await fetchAnimals()
//            let productions = try await fetchProductions()
//
//            var animalsList = animalsRecords.map { record -> Animal in
//                let animal = record.fields
//                return animal
//            }
//            
//            attachProductions(animals: &animalsList, productions: productions)
//            self.animals = animalsList.sorted { $0.id < $1.id }
//
//        } catch {
//            print("Error fetching animals or productions: \(error)")
//        }
//    }
//
//    private func fetchAnimals() async throws -> [AnimalRecord] {
//        var request = URLRequest(url: baseAnimalsURL)
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//
//        let (data, _) = try await URLSession.shared.data(for: request)
//
//        let decoder = JSONDecoder()
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd"
//                    formatter.locale = Locale(identifier: "en_US_POSIX")
//                    decoder.dateDecodingStrategy = .formatted(formatter)
//        
//        let response = try decoder.decode(AnimalsResponse.self, from: data)
//        return response.records
//    }
//
//    private func fetchProductions() async throws -> [ProductionData] {
//        var request = URLRequest(url: baseProductionsURL)
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//
//        let (data, _) = try await URLSession.shared.data(for: request)
//
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//
//        let response = try decoder.decode(ProductionResponse.self, from: data)
//
//        return response.records.map { record -> ProductionData in
//            let production = record.fields
//            return production
//        }
//    }
//
//    private func attachProductions(animals: inout [Animal], productions: [ProductionData]) {
//        let productionDict = Dictionary(uniqueKeysWithValues: productions.map { ($0.id, $0) })
//        for animal in animals {
//            guard let ids = animal.productionIDs else { continue }
//            animal.productionRows = ids.compactMap { id in
//                guard let production = productionDict[id] else { return InfoRow(label: "", value: "") }
//                return InfoRow(
//                    label: "\(production.date)",
//                    value: "\(production.amount) \(production)"
//                )
//            }
//        }
//    }
//}
