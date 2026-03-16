//
//  EmployeeViewModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import Foundation
import Observation

@Observable @MainActor

class EmployeeViewModel {
    private let apiKey: String =
        "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"

    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Employee"
    )!

    var employees: [Employee] = []

    func fetchEmployees() async {

        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let decoded = try decoder.decode(EmployeesResponse.self, from: data)
            let employees = decoded.records.map{ record -> Employee in
                let employee = record.fields
                employee.recordID = record.id
                return employee
            }
            self.employees = employees
            //                        return animals
        } catch {
            print("Échec du décodage: \(error)")
            //                        throw error
        }
    }
}
