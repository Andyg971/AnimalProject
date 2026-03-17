//
//  discussionTopic.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import Foundation

struct DiscussionResponse: Codable {
    var records: [DiscussionRecord]
}

struct DiscussionRecord: Codable {
    var fields: DiscussionTopic
}


struct DiscussionTopic: Codable{
    var nomDiscussions: String
    var nombreMessage: Int
    var dernierscommentaire: String
    var date: String
}
