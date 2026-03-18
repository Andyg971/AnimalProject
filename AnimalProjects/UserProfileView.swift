//
//  UserProfile.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 16/03/2026.
//

import SwiftUI

struct UserProfileView: View {
    //    @State var vmExploitation: ExploitationViewModel = .init()
    //    @State var exploitation: ExploitationField = ExploitationField(farmName: "Na", farmPlace: "", farmType: [])
    @State private var showSettings = false
    //    let employee: Employee
    
    var body: some View {
        NavigationStack {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
            
           
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.vertClair)
                                .frame(width: 120, height: 120)
                            Image("Pierre")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }
                        .padding(20)
                        
                        VStack(spacing:8) {
                            Text("Pierre Martin")
                                .font(.system(size:24, weight: .bold))
                            Text ("Éleveur")
                                .font(.system(size:20, weight: .bold))
                                .foregroundStyle(Color.vertAccent)
                        }
                        VStack(spacing:12) {
                            
                            EmpDetailRowView(title:"Nom d'utilisateur", value: "pierrem")
                            EmpDetailRowView(title:"email", value: "pierre.martin@lafermedespresverts.fr")
                            EmpDetailRowView(title: "ville",
                                             value:"Villeurbanne")
                            EmpDetailRowView(title: "Exploitation", value: "La Ferme des Près vert")
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bio")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Je suis Pierre, éleveur passionné, toujours prêt à m'investir pour le bien-être des animaux. Mon expérience et ma rigueur font de moi un pilier de l'exploitation")
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
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Photos")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 3)
                        LazyVGrid(columns: columns, spacing: 6) {
                            Image("p1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Image("p2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Image("p3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Image("p4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
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
                    .background(Color.vertClair.opacity(0.5))
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
        .navigationTitle("Mon Profil")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showSettings) {
            SettingsView()
        }
    }
}
        
   

#Preview {
    UserProfileView()
}

