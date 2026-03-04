//
//  Models.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import Foundation
import Observation
import SwiftUI

enum Species: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case bovine = "Bovin"
    case caprine = "Caprin"
    case equine = "Équin"
    case ovine = "Ovin"
    case porcine = "Porcin"
}

enum Production: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case milk = "Lait"
    case wool = "Laine"
    case meat = "Viande"
}

@Observable
class Animal: Identifiable {
    var id = UUID()
    var photo: String?
    let species: Species
    let idNumber: String
    let name: String?
    let dateOfBirth: Date?
    let isMale: Bool
    let production: Production?
    var isPregnant: Bool

    init(
        photo: String? = nil,
        species: Species,
        idNumber: String,
        name: String? = nil,
        dateOfBirth: Date? = nil,
        isMale: Bool,
        production: Production?,
        isPregnant: Bool = false
    ) {
        self.photo = photo
        self.species = species
        self.idNumber = idNumber
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        self.production = production
        self.isPregnant = isPregnant
    }
}

@Observable
class Employee: Identifiable {
    var id = UUID()
    var photo: String?
    let firstName: String
    let lastName: String
    var position: String
    var zone: String?

    init(
        id: UUID = UUID(),
        photo: String? = nil,
        firstName: String,
        lastName: String,
        position: String,
        zone: String? = nil
    ) {
        self.id = id
        self.photo = photo
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.zone = zone
    }
}

enum Event: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case insemination = "Insémination"
    case pregnancy = "Gestation"
    case birth = "Mise bas"
    case vaccination = "Vaccination"
    case treatment = "Traitement"
    case shearing = "Tonte"
    case slaughter = "Abbattage"
    case disease = "Maladie"
}
@Observable
class CommunityCategory: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    var threadNumber: Int
    let activeName: String
    let link: (any View)?
    
    init(id: UUID = UUID(), title: String, description: String, threadNumber: Int, activeName: String, link: (any View)? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.threadNumber = threadNumber
        self.activeName = activeName
        self.link = link
    }
    
}
