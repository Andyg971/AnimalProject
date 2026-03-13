//
//  Models.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import Observation
import SwiftUI


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
