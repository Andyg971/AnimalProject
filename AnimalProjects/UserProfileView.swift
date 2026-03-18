//
//  UserProfile.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 16/03/2026.
//

import SwiftUI

struct UserProfileView: View {
    @State var vmExploitation: ExploitationViewModel = .init()
    @State var exploitation: ExploitationField = ExploitationField(farmName: "Na", farmPlace: "", farmType: [])
    @State private var showSettings = false
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
                            
                            EmpDetailRowView(title:"Nom d'utilisateur", value: employee.userName)
                            EmpDetailRowView(title:"email", value: employee.email)
                            EmpDetailRowView(title: "ville",
                                             value: employee.city ?? "Non renseigné")
                            EmpDetailRowView(title: "Exploitation", value: exploitation.farmName)
                            
                        }
                        if let bio = employee.bioUser, !bio.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Bio")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(Color.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(bio)
                                    .font(.system(size: 15))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
//                                    .background(Color.vertAccent.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                                        )
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                        }
                        if let photos = employee.photosUser, !photos.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Photos")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(Color.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 16)
                                
                                let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 3)
                                LazyVGrid(columns: columns, spacing: 6) {
                                    ForEach(photos, id: \.id) { attachment in
                                        
                                        AsyncImage(url: attachment.url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.vertClair
                                        }
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.top, 12)
                        }
                        VStack(spacing: 12) {
                            Button {
                                showSettings = true
                            } label: {
                                HStack {
                                    Image(systemName: "gearshape")
                                    Text("Paramètres")
                                }
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.vertDark)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
//                                .background(Color.vertClair.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.secondary.opacity(1), lineWidth: 1)
                                        )
                            }
                            
                            Button {
                            } label: {
                                Text("Déconnexion")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 13)
                                    .background(Color(.systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.red.opacity(1), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 32)
                    }
                }
                
                
                .navigationTitle("Mon Profil")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(isPresented: $showSettings) {
                    SettingsView()
                }
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
        }
    }
}


#Preview {
    UserProfileView(employee: Employee(id: 9, firstName: "Thomas", lastName: "Faure", photo:[], position: "Conducteur d'élevage", zone: ["Infirmarie", "Bâtiment d'élevage"], userName: "thomasf", email: "thomas.faure@domaine-soleil.fr", exploitation: ["recqRtgdpGSlWGC5B"], city: "Sainte-Foy-lès-Lyon", recordID: "recqRtgdpGSlWGC5B", bioUser: "Thomas, conducteur d'élevage, est apprécié pour sa force de travail et sa capacité à gérer les situations d'urgence sur la ferme.", photosUser: []))
}

