//
//  Models.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import Observation
import SwiftUI




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




enum Event: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case heat = "Chaleur"
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
class MilkData: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var amount: Double
    var tB: Double
    var tP: Double
    var cellCount: Double
    var ketone: Double?

    init(
        id: UUID,
        date: Date,
        amount: Double,
        tB: Double,
        tP: Double,
        cellCount: Double,
        ketone: Double? = nil
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.tB = tB
        self.tP = tP
        self.cellCount = cellCount
        self.ketone = ketone
    }
}

@Observable
class MeatData: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var amount: Double

    init(id: UUID, date: Date, amount: Double) {
        self.id = id
        self.date = date
        self.amount = amount
    }
}

@Observable
class WoolData: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var numberOfAnimals: Int
    var amount: Double

    init(id: UUID, date: Date, numberOfAnimals: Int, amount: Double) {
        self.id = id
        self.date = date
        self.numberOfAnimals = numberOfAnimals
        self.amount = amount
    }

}

struct Document: Identifiable {
    var id = UUID()
    let title: String
    let type: String
    let size: Int
    let date: Date
}
