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
struct AnimalRecord: Codable, Identifiable {
    let id: String
    let createdTime: Date
    let fields: Animal
}

//@Observable
class Animal: Codable {
//    var id = Int
    var photo: String?
    let species: Species?
    let race: String?
    let idNumber: Int
    let name: String?
    let dateOfBirth: Date?
    let isMale: Bool
    let productionType: Production?
    var isPregnant: Bool
//    private enum CodingKeys: String, CodingKey {
//        c
    init(
        photo: String? = nil,
        species: Species,
        race: String? = nil,
        idNumber: Int,
        name: String? = nil,
        dateOfBirth: Date? = nil,
        isMale: Bool,
        productionType: Production?,
        isPregnant: Bool = false
    ) {
        self.photo = photo
        self.species = species
        self.race = race
        self.idNumber = idNumber
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        self.productionType = productionType
        self.isPregnant = isPregnant
    }
}

