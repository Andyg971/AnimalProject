//
//  EmployeeAttachment.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 12/03/2026.
//

import Foundation

struct Attachment: Codable {
    let id: String
    let url: URL
    let thumbnails: Thumbnails?
}
struct Thumbnails : Codable {
    let small: ThumbnailVariant?
    let large: ThumbnailVariant?
    let full: ThumbnailVariant?
}
struct ThumbnailVariant: Codable{
    let url: URL
}
