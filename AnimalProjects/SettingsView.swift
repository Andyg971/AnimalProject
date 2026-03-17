//
//  SettingsView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 16/03/2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var showDeleteAlert = false
 
    var body: some View {
        ZStack {
            Color.grisFond
                .ignoresSafeArea()
 
            VStack(spacing: 20) {
 
                VStack(spacing: 0) {
//                    NavigationLink(destination: Text("Compte")) {
                        SettingsRowView(icon: "person.circle", title: "Compte")
//                    }
                    Divider().padding(.leading, 52)
 
//                    NavigationLink(destination: Text("Notifications")) {
                        SettingsRowView(icon: "bell", title: "Notification")
//                    }
                    Divider().padding(.leading, 52)
 
//                    NavigationLink(destination: Text("Aide & info")) {
                        SettingsRowView(icon: "questionmark.circle", title: "Aide & info")
//                    }
                }
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.top, 24)
 
               
                Button {
                    showDeleteAlert = true
                } label: {
                    Text("Supprimer le compte")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 16)
 
                Spacer()
            }
        }
        .navigationTitle("Paramètres")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Supprimer le compte", isPresented: $showDeleteAlert) {
            Button("Annuler", role: .cancel) {}
            Button("Supprimer", role: .destructive) {
             
            }
        } message: {
            Text("Cette action est irréversible. Ton compte sera définitivement supprimé.")
        }
    }
}
 
 

 
#Preview {
    NavigationStack {
        SettingsView()
    }
}
 
