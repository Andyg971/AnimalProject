//
//  CategoryModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Observation
import SwiftUI

struct CommunityResponse: Codable {
    let records: [CommunityRecord]
}
struct CommunityRecord: Codable {
    //    let id: Int
    let createdTime: Date
    let fields: CommunityCategory
}

class CommunityCategory: Codable, Identifiable {
    var id: Int
    let title: String
    let description: String
    var threadNumber: Int
    let activeName: String
    let discutions: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "communityID"
        case title
        case description
        case threadNumber
        case activeName
        case discutions
    }

    init(
        id: Int,
        title: String,
        description: String,
        threadNumber: Int,
        activeName: String,
        discutions: [String]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.threadNumber = threadNumber
        self.activeName = activeName
        self.discutions = discutions
    }

}

func communityStyle(for title: String) -> (icon: String, color: Color) {
    let t = title.lowercased()

    if t.contains("santé") {
        return ("cross.case.fill", .red)

    }
    if t.contains("reproduction") {
        return ("heart.fill", .pink)
    }

    if t.contains("discussion") {
        return ("bubble.left.fill", .blue)
    }
    if t.contains("aide") {
        return ("questionmark.circle.fill", .yellow)
    }

    return ("bubble.left.fill", .blue)
}
