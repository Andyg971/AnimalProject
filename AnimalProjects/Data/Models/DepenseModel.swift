//
//  DepenseModel.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 12/03/2026.
//

import Foundation

struct Depense: Identifiable {
    
    var id = UUID()
    var categorie: String
    var cout: Double
    var quantite: Double
    var total: Double
    var date: Date
    
}
