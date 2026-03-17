//
//  CalendarTheme.swift
//  AnimalProjects
//
//  Created by apprenant79 on 16/03/2026.
//

import SwiftUI
import Observation

struct CalendarEvent: Identifiable {
    let id = UUID()
//    let eventType: EventType
    let date: Date
    let color: Color
}

enum EventType: String, CaseIterable, Identifiable {
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
class CalendarViewModel {
    var displayedMonth: Date = Date()
    var selectedDate: Date = Date()
    var events: [CalendarEvent] = []

    var calendar: Calendar {
        var cal = Calendar.current
        cal.locale = Locale(identifier: "fr_FR")
        cal.firstWeekday = 2
        return cal
    }

    var month: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
    }

    var weekdays: [String] {
        let symbols = calendar.shortStandaloneWeekdaySymbols
        let first = calendar.firstWeekday - 1
        return Array(symbols[first..<symbols.count] + symbols[0..<first])
    }

    var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }
        return range.compactMap { day -> Date? in
            calendar.date(bySetting: .day, value: day, of: month)
        }
    }
    
    var monthGrid: [Date] {
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth)
        let leading = (weekdayOfFirst - calendar.firstWeekday + 7) % 7
        let range = calendar.range(of: .day, in: .month, for: displayedMonth)!
        let daysInMonth = range.compactMap { day -> Date? in
            calendar.date(bySetting: .day, value: day, of: firstOfMonth)
        }

        let prevMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth)!
        let prevMonthRange = calendar.range(of: .day, in: .month, for: prevMonth)!
        let prevDays = prevMonthRange.suffix(leading).compactMap { day -> Date? in
            calendar.date(bySetting: .day, value: day, of: prevMonth)
        }

        let totalCells = prevDays.count + daysInMonth.count
        let trailing = (7 - (totalCells % 7)) % 7
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth)!
        let nextDays = (1...trailing).compactMap { day -> Date? in
            calendar.date(bySetting: .day, value: day, of: nextMonth)
        }

        return Array(prevDays) + daysInMonth + nextDays
    }

    var eventsDict: [Date: [CalendarEvent]] {
        Dictionary(grouping: events) { calendar.startOfDay(for: $0.date) }
    }
}
