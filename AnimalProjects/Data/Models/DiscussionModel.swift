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
    var nbMessages: Int
    var dernierCommentaire: String
    var date: Date
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "'le' dd/MM/yyyy 'à' HH:mm"
        return formatter.string(from: self.date)
    }
}


