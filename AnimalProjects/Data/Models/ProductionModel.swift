//
//  ProductionModel.swift
//  AnimalProjects
//
//  Created by apprenant79 on 16/03/2026.
//

import Observation
import SwiftUI

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

    init(
        id: Int,
        date: Date,
        productionType: ProductionType,
        amount: Double,
        unit: String,
        tB: Double? = nil,
        tP: Double? = nil,
        cellCount: Int? = nil,
        ketone: Int? = nil
    ) {
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

    init(
        id: Int,
        date: Date,
        productionType: ProductionType,
        amount: Double,
        unit: String
    ) {
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

    init(
        id: Int,
        date: Date,
        productionType: ProductionType,
        amount: Double,
        unit: String,
        tB: Double,
        tP: Double,
        cellCount: Int,
        ketone: Int? = nil
    ) {
        self.tB = tB
        self.tP = tP
        self.cellCount = cellCount
        self.ketone = ketone
        super.init(
            id: id,
            date: date,
            productionType: productionType,
            amount: amount,
            unit: unit
        )
    }
}

enum ProductionType: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case milk = "Lait"
    case wool = "Laine"
    case meat = "Viande"

    var symbol: String {
        switch self {
        case .milk:
            "drop.fill"
        case .meat:
            "fork.knife"
        case .wool:
            "line.3.crossed.swirl.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .milk:
            .white
        case .meat:
            .red
        case .wool:
            .gray
        }
    }
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
        return ProductionData(
            id: fields.id,
            date: fields.date,
            productionType: fields.productionType,
            amount: fields.amount,
            unit: fields.unit
        )
    }
}

struct AggregatedProduction: Identifiable {
    var id: Date { period }
    let period: Date
    let amount: Double
    let unit: String
}

func weeklyProduction(from data: [ProductionData]) -> [AggregatedProduction] {
    let calendar = Calendar.current
    let grouped = Dictionary(grouping: data) { prod in
        calendar.dateInterval(of: .weekOfYear, for: prod.date)!.start
    }

    return grouped.map { weekStart, values in
        AggregatedProduction(
            period: weekStart,
            amount: values.reduce(0) { $0 + $1.amount },
            unit: values.first?.unit ?? ""
        )
    }
    .sorted { $0.period < $1.period }
}

func monthlyProduction(from data: [ProductionData]) -> [AggregatedProduction] {
    let calendar = Calendar.current
    let grouped = Dictionary(grouping: data) { item in
        calendar.dateComponents([.year, .month], from: item.date)
    }

    return grouped.map { key, values in
        let total = values.reduce(0) { $0 + $1.amount }
        let monthStart = calendar.date(from: key) ?? Date()
        return AggregatedProduction(
            period: monthStart,
            amount: total,
            unit: values.first?.unit ?? ""
        )
    }
    .sorted { $0.period < $1.period }
}

enum ViewMode: String, CaseIterable, Identifiable {
    case weekly = "Semaine"
    case monthly = "Mois"

    var id: String { self.rawValue }
    var title: String { self.rawValue }
    var chartUnit: Calendar.Component {
        switch self {
        case .weekly: return .weekOfYear
        case .monthly: return .month
        }
    }
}
