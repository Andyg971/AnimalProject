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
        
        
    )
    {
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

struct ProductionResponse: Codable {
    let records: [ProductionRecord]
}

struct ProductionRecord: Codable {
    let fields: ProductionField
}
struct ProductionField: Codable, Identifiable {
    var id: Int
    let date: Date
    let productionType: ProductionType
    let amount: Double
    let unit: String
    let tB: Double?
    let tP: Double?
    let cellCount: Int?
    let ketone: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "productionID"
        case date
        case productionType
        case amount
        case unit
        case tB = "TB"
        case tP = "TP"
        case cellCount
        case ketone
    }
    
    init(id: Int, date: Date, productionType: ProductionType, amount: Double, unit: String, tB: Double? = nil, tP: Double? = nil, cellCount: Int? = nil, ketone: Int? = nil) {
        self.id = id
        self.date = date
        self.productionType = productionType
        self.amount = amount
        self.unit = unit
        self.tB = tB
        self.tP = tP
        self.cellCount = cellCount
        self.ketone = ketone
    }

}

class ProductionData: Identifiable {
    var id: Int
    let date: Date
    let productionType: ProductionType
    let amount: Double
    let unit: String
    
    
    init(id: Int, date: Date, productionType: ProductionType, amount: Double, unit: String) {
        self.id = id
        self.date = date
        self.productionType = productionType
        self.amount = amount
        self.unit = unit
    }
}

class ProductionMilk: ProductionData {
    let tB: Double
    let tP: Double
    let cellCount: Int
    let ketone: Int?
    
    
    init(id: Int, date: Date, productionType: ProductionType, amount: Double, unit: String, tB: Double, tP: Double, cellCount: Int, ketone: Int? = nil) {
        self.tB = tB
        self.tP = tP
        self.cellCount = cellCount
        self.ketone = ketone
        super.init(id: id, date: date, productionType: productionType, amount: amount, unit: unit)
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

enum ProductionType: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case milk = "Lait"
    case wool = "Laine"
    case meat = "Viande"
}

func convertProduction(_ record: ProductionRecord) -> ProductionData {
    let fields = record.fields
    if fields.productionType == .milk {
        return ProductionMilk(
            id: record.fields.id,
            date: record.fields.date,
            productionType: .milk,
            amount: Double(record.fields.amount),
            unit: "L",
            tB: fields.tB!,
            tP: fields.tP!,
            cellCount: fields.cellCount!,
            ketone: fields.ketone
        )
    } else {
        return ProductionData(id: fields.id, date: fields.date, productionType: fields.productionType, amount: fields.amount, unit: fields.unit)
    }
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
