//
//  TaskRowView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 13/03/2026.
//

import SwiftUI

struct TaskRowView: View {
    @State var task: TaskField
    @State var originalStatus: String? = nil
    let vmTask: TaskViewModel
    var body: some View {
       
        HStack(alignment: .top, spacing: 12) {
            Button {
                if originalStatus == nil {
                    originalStatus = task.status
                }
                let currentValue = task.completed ?? false
                task.completed = !currentValue
                if task.completed == true {
                    task.status = "Fait"
                } else {
                    task.status = originalStatus
                }
                Task {
                    await vmTask.updateTaskCompletion(task: task)
                }
            } label: {
                Image(systemName: task.completed == true ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.completed == true ? .vertAccent : .gray)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(task.taskName ?? "Sans titre")
                    .font(.system(size: 16, weight: .semibold))
                
                Text(task.status ?? "Sans statut")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.white.opacity(0.7))
        .cornerRadius(12)
        .onAppear {
            originalStatus = task.status
        }
    }
    func toggleTask() {
        Task {
            await vmTask.updateTaskCompletion(task: task)
        }
    }
}

#Preview {
    TaskRowView(
        task: TaskField(id: 1, taskName: "Nourrir les veaux", description: "", status: "À faire", completed: false, assignedTo: ["4"],recordID: ""), vmTask: TaskViewModel()
    )
}
