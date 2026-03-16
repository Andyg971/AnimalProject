//
//  TaskModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 13/03/2026.
//

import Foundation

struct TaskResponse: Codable {
    let records: [TaskRecord]
}
struct TaskRecord: Codable {
    let id: String
    let createdTime: Date
    let fields: TaskField
}

struct TaskField : Identifiable, Codable {
    var id: Int?
    var taskName: String?
    var description: String?
    var status: String?
    var completed: Bool?
    var assignedTo: [String]?
    var recordID: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "taskID"
        case taskName
        case description
        case status
        case completed
        case assignedTo
        case recordID
    }
    init (
        id: Int,
        taskName: String,
        description: String,
        status: String,
        completed: Bool,
        assignedTo: [String],
        recordID: String
    ) {
        self.id = id
        self.taskName = taskName
        self.description = description
        self.status = status
        self.completed = completed
        self.assignedTo = assignedTo
        self.recordID = recordID
    }
}
