//
//  AnimalModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Observation
import SwiftUI

struct AnimalsResponse: Codable {
    let records: [AnimalRecord]
}

struct AnimalRecord: Codable {
    let fields: Animal
}

class Animal: Codable, Identifiable {
    var id: Int
    var photo: [Attachment]?
    let species: Species
    let race: String
    let name: String?
    let dateOfBirth: Date?
    let isMale: Bool?
    let productionType: ProductionType?
    var isPregnant: Bool?
    var productionIDs: [String]?
    var healthIDs: [String]?

    init(
        id: Int,
        photo: [Attachment]? = nil,
        species: Species,
        race: String,
        name: String? = nil,
        dateOfBirth: Date? = nil,
        isMale: Bool = false,
        productionType: ProductionType?,
        isPregnant: Bool = false,
        productionIDs: [String]? = nil,
        healthIDs: [String]? = nil

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
        self.productionIDs = productionIDs
        self.healthIDs = healthIDs

    }
    private enum CodingKeys: String, CodingKey {
        case id = "idNumber"
        case photo
        case species
        case race
        case name
        case dateOfBirth
        case isMale
        case productionType
        case isPregnant
        case productionIDs = "production"
        case healthIDs = "health"
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

let animalTest = Animal(
    id: 0,
    species: .bovine,
    race: "RaceExemple",
    productionType: .milk,
    //    productionIDs: [InfoRow(
    //        label: "00/00/00",
    //        value: "00 L ou kg")]
)

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

let reproductionRows: [InfoRow] = [
    InfoRow(label: "Prochaine Insémination", value: "21/02/2027")
]
