//
//  EmployeeDetailView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct EmployeeDetailView: View {
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
                            Image(systemName:"person.fill")
                                .font(.system(size:48))
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
                            DetailRowView(title: "Zone",
                                          value: employee.zone?.joined(separator: ",") ?? "Non renseigné"
                            )
                            DetailRowView(title: "UserName", value: employee.userName)
                            DetailRowView(title:"Email", value: employee.email)
                        }
                    }
                }
                .navigationTitle("Profil")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    EmployeeDetailView(employee: Employee(id: 1, firstName: "Pierre", lastName: "Martin", position: "Éleveur",zone: ["Batiment d'elevage","Exploitation"], userName: "pierrem", email: "pierre.martin@domaine-soleil.fr"))
}
