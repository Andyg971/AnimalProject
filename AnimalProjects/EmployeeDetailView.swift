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
                           
                                DetailRowView(title:"Exploitation", value: exploitation.farmName)
                            
//                            DetailRowView(title:"Localisation", value: employee.farmPlace ?? "Non renseigné")
                            DetailRowView(title: "Zone",
                                          value: employee.zone?.joined(separator: ", ") ?? "Non renseigné")
                            DetailRowView(title: "UserName", value: employee.userName)
                            DetailRowView(title:"Email", value: employee.email)
                            DetailRowView(title:"Ville", value: employee.city ?? "Non renseigné")
                            
                        }
                    }
                }
                .navigationTitle("Profil")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task{
            if let exploitationID = employee.exploitation?.first{
               
//                var expID: [ExploitationField] = []
               
                do {
                    self.exploitation = try await vmExploitation.getExploitationByID(id: exploitationID)
                
                }catch{
                    print(error)
                }
//                exploitation = expID
            }
        }
    }
}

//#Preview {
//    EmployeeDetailView(exploitation: ExploitationField(from: <#any Decoder#>, id: "La ferme de Prés", farmPlace: "Lyon", farmType: "Bovin" ), employee: Employee(id: 1, firstName: "Pierre", lastName: "Martin", position: "Éleveur",zone: ["Batiment d'elevage","Exploitation"], userName: "pierrem", email: "pierre.martin@domaine-soleil.fr", city: "Villeurbanne"))
//}
