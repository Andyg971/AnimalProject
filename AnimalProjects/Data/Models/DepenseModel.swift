//
//  DepenseModel.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 12/03/2026.
//

import Foundation

struct DepenseResponse: Codable {
    var records: [DepenseRecord]
}

struct DepenseRecord: Codable {
    var fields: Depense
}

struct Depense: Codable {
    var categorie: String
    var cout: Double
    var quantite: Double
    var total: Double
    var date: Date
    
    private enum CodingKeys: String, CodingKey {
        case categorie = "name"
        case cout = "amount"
        case quantite = "quantity"
        case total = "budget"
        case date
    }
}
