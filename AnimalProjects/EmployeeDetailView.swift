//
//  EmployeeDetailView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct EmployeeDetailView: View {
    @State var vmExploitation: ExploitationViewModel = .init()
    @State var exploitation: ExploitationField = ExploitationField(farmName: "Na", farmPlace: "", farmType: [])
        @State var vmTask: TaskViewModel = .init()
     let employee: Employee

    var body: some View {
        
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.vertClair)
                                .frame(width: 120, height: 120)
                            if let url = employee.photo?.first?.url {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                            } else {
                                Image(systemName:"person.fill")
                                    .font(.system(size:48))
                            }
                        }
                        .padding(20)
                        
                        VStack(spacing:8) {
                            Text("\(employee.firstName) \(employee.lastName)")
                                .font(.system(size:24, weight: .bold))
                            Text (employee.position)
                                .font(.system(size:20, weight: .bold))
                                .foregroundStyle(Color.vertAccent)
                        }
                        VStack(spacing:12) {
                           
                                EmpDetailRowView(title:"Exploitation", value: exploitation.farmName)
                            EmpDetailRowView(title:"Localisation", value: exploitation.farmPlace)
                            EmpDetailRowView(title: "Zone",
                                          value: employee.zone?.joined(separator: ", ") ?? "Non renseigné")
                        }
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Tâches")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color.vertAccent)
                            
                            if vmTask.tasks.filter({ $0.assignedTo?.contains(employee.recordID ?? "") ?? false}).isEmpty {
                                Text("Aucune tâche assignée")
                                    .foregroundStyle(.secondary)
                            } else {
                                ForEach(vmTask.tasks.filter { task in
                                    task.assignedTo?.contains(employee.recordID ?? "") ?? false
                                }) { task in
                                    TaskRowView(task: task, vmTask: vmTask)
                                        .padding(.vertical, 4)
                                }
                                }
                            }
                    }
                }
                .navigationTitle("Profil")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task{
            if let exploitationID = employee.exploitation?.first{
               
                do {
                    self.exploitation = try await vmExploitation.getExploitationByID(id: exploitationID)
                
                }catch{
                    print(error)
                }
            }
            await vmTask.fetchTasks()
        }
    }
}

#Preview {
    EmployeeDetailView(employee: Employee(id: 9, firstName: "Thomas", lastName: "Faure", photo:[], position: "Conducteur d'élevage", zone: ["Infirmarie", "Bâtiment d'élevage"], userName: "", email: "", exploitation: ["recqRtgdpGSlWGC5B"], city: "", recordID: "recqRtgdpGSlWGC5B"))
}
