//
//  TaskViewModel.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 13/03/2026.
//

import Foundation
@Observable @MainActor
class TaskViewModel {
    private let apiKey: String =
    "patGfr1JzHwdDpeDx.6ac1bae5fe4bc558e2ba85b986add1dc110887bde5b255bc34b595b3c832da66"
    
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Tasks"
    )!
    var tasks: [TaskField] = []
    
    func fetchTasks() async {
        
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
            
            let decoded = try decoder.decode(TaskResponse.self, from: data)
            let tasks = decoded.records.map { record -> TaskField in
                var task = record.fields
                task.recordID = record.id
                return task
            }
            self.tasks = tasks
            //                        return animals
        } catch {
            print("Échec du décodage: \(error)")
            //                        throw error
        }
    }
    func updateTaskCompletion(task: TaskField) async {
        if let index = tasks.firstIndex(where: { $0.recordID == task.recordID}) {
            tasks[index].completed = task.completed
            tasks[index].status = task.status
        }
    }
}
    
//    func updateTaskCompletion(task: TaskField) async {
//guard let recordID = task.recordID else { return }
//
//        let url = URL(string:"https://api.airtable.com/v0/appnYAHRHXyCtWA4a/Tasks/\(recordID)")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let newValue = !(task.completed ?? false)
//
//        let body: [String: Any] = [
//            "fields": [
//                "completed": newValue
//            ]
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//        do {
//
//            let (_, _) = try await URLSession.shared.data(for: request)
//
//            await fetchTasks()
//
//        } catch {
//
//            print(error)
//
//        }

//    }

