//
//  AnimalModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Foundation
import Observation

struct AnimalsResponse: Codable {
    let records: [AnimalRecord]
}
struct AnimalRecord: Codable {
//    let id: String
//    let createdTime: Date
    let fields: Animal
}

//@Observable
class Animal: Codable, Identifiable {
    var id: Int
    var photo: String?
    let species: Species
    let race: String
//    let idNumber: Int
    let name: String?
    let dateOfBirth: Date?
    let isMale: Bool?
    let productionType: Production?
    var isPregnant: Bool?
    private enum CodingKeys: String, CodingKey {
        case id = "idNumber"
        case photo
        case species
        case race
//        case idNumber
        case name
        case dateOfBirth
        case isMale
        case productionType
        case isPregnant
    }
    init(
        id: Int,
        photo: String? = nil,
        species: Species,
        race: String,
//        idNumber: Int,
        name: String? = nil,
        dateOfBirth: Date? = nil,
        isMale: Bool = false,
        productionType: Production?,
        isPregnant: Bool = false
    ) {
        self.id = id
        self.photo = photo
        self.species = species
        self.race = race
//        self.idNumber = idNumber
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        self.productionType = productionType
        self.isPregnant = isPregnant
    }
}

enum Species: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case porcine = "Porcin"
    case bovine = "Bovin"
    case caprine = "Caprin"
    case equine = "Équin"
    case ovine = "Ovin"
   
}

enum Production: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case milk = "Lait"
    case wool = "Laine"
    case meat = "Viande"
}

let animalTest = Animal(id: 0, species: .bovine, race: "RaceExemple", productionType: .milk)

struct InfoRow: Identifiable {
    var id = UUID()
    let label: String
    let value: String
}

let healthRows: [InfoRow] = [
    InfoRow(label: "Vaccins", value: "À jour"),
    InfoRow(label: "Dernier Examen", value: "21/02/2026"),
    InfoRow(label: "Alertes", value: "Aucune"),
    ]

let productionRows: [InfoRow] = [
    InfoRow(label: "Quantité", value: "100 L"),
    InfoRow(label: "Dernier Echantillon", value: "21/02/2026"),
]

let reproductionRows: [InfoRow] = [
    InfoRow(label: "Prochaine Insémination", value: "21/02/2027"),
]
