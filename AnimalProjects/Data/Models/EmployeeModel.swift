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
    var exploitation: [String]?
    var city: String?
//    var farmPlace: String?
    var tasks: [String]?
    
    private enum CodingKeys: String, CodingKey {
    case id = "employeeID"
        case firstName
        case lastName
//        case photo
        case position
        case zone
        case userName
        case email
        case exploitation
        case city
//        case farmPlace
        case tasks
    }
    init(
        id: Int,
        
        firstName: String,
        lastName: String,
//        photo: String? = nil,
        position: String,
        zone: [String]? = nil,
        userName: String,
        email: String,
        exploitation: [String]? = nil,
        city: String? = nil,
//        farmPlace: String? = nil,
        tasks: [String]? = nil
        
    ) {
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
//        self.photo = photo
        self.position = position
        self.zone = zone
        self.userName = userName
        self.email = email
        self.exploitation = exploitation
        self.city = city
//        self.farmPlace = farmPlace
        self.tasks = tasks
    }
}
struct ExploitationResponse: Codable {
    let records: [EmployeeRecord]
}
struct ExploitationRecord: Codable, Identifiable {
    let id: String
//    let createdTime: Date
    let fields: ExploitationField
}
struct ExploitationField: Codable {
    var farmName: String
    let farmPlace: String
    let farmType: [String]
    
//    private enum CondingKeys: String, CodingKey {
//        case id = "farmName"
//        case farmPlace
//        case farmType
//    }
}
