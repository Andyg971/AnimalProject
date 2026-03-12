//
//  DocumentsModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import Foundation
import Observation

struct DocumentsResponse: Codable {
    let records: [DocumentsRecord]
}
struct DocumentsRecord: Codable {
//    let id: String
//    let createdTime: Date
    let fields: Document
}

struct Document: Codable, Identifiable {
    var id: Int
    let title: String
    let type: DocumentType
    let size: Int
    let date: Date?
    let description: String?
//    let file: String?
    let attachment: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case title, date, type, size, description
//        case file
        case attachment = "Attachment"
    }
}

enum DocumentType: String, Codable, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case admin = "Administratif"
    case health = "Santé"
    case production = "Production"
   
}
