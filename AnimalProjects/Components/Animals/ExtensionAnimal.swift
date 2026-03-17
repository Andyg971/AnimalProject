//
//  ExtensionAnimal.swift
//  AnimalProjects
//
//  Created by apprenant79 on 17/03/2026.
//

import SwiftUI
extension AnimalDetails {
    var age: Int? {
        guard let birthday = animal.dateOfBirth else { return nil }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents(
            [.year],
            from: birthday,
            to: Date()
        )
        return ageComponents.year
    }
    
    var prodRows: [InfoRow] {
        prodList.map { prod in
            InfoRow(
                label: prod.date.formatted(date: .numeric, time: .omitted),
                value: "\(prod.amount) \(prod.unit)"
            )
        }
    }
    var healthRows: [InfoRow] {
        healthList.map { health in
            InfoRow(
                label: health.date.formatted(date: .numeric, time: .omitted),
                value: health.title
            )
        }
    }
    
    var calendarEvents: [CalendarEvent] {
        healthList.map {
            CalendarEvent(date: $0.date, color: .red)
        }
    }
    
    
}
