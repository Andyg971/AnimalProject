//
//  EmployeeModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Foundation
import Observation

struct EmployeesResponse: Codable {
    let records: [EmployeeRecord]
}
struct EmployeeRecord: Codable, Identifiable {
    let id: String
    let createdTime: Date
    let fields: Employee
}
//@Observable
class Employee: Codable, Identifiable {
    var id: Int
    let firstName: String
    let lastName: String
//    var photo: String?
    var position: String
    var zone: [String]?
    var userName: String
    var email: String
    
    private enum CodingKeys: String, CodingKey {
    case id = "employeeID"
        case firstName
        case lastName
//        case photo
        case position
        case zone
        case userName
        case email
    }
    init(
        id: Int,
        
        firstName: String,
        lastName: String,
//        photo: String? = nil,
        position: String,
        zone: [String]? = nil,
        userName: String,
        email: String
        
    ) {
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
//        self.photo = photo
        self.position = position
        self.zone = zone
        self.userName = userName
        self.email = email
    }
}
