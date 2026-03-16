//
//  message.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import Foundation

struct Message: Identifiable {
    
    let id = UUID()
    
    var text: String
    var date: Date
}
