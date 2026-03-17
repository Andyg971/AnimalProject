//
//  ContentView.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import SwiftUI

struct ContentView: View {
    init() {
    
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "grisFond")
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named:"vertAccent")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "vertAccent")!]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
   
        TabView {
            
            DashboardView()
                .tabItem{
                    Label("Tableau de bord", systemImage: "doc.fill")

                }
            AnimalView()
                .tabItem{
                    Label("Mes Animaux", systemImage: "pawprint.fill")
                }
            CommunityView()
                .tabItem{
                    Label("Communauté", systemImage: "message.fill")
                }
            UserProfileView(employee: Employee(
                id: 9,
                firstName: "Thomas",
                lastName: "Faure",
                photo: [],
                position: "Conducteur d'élevage",
                zone: [],
                userName: "thomasf",
                email: "thomas.faure@domaine-s.fr",
                exploitation: ["recqRtgdpGSlWGC5B"],
                city: "Sainte-Foy-lès-Lyon",
                recordID: "recqRtgdpGSlWGC5B"
            ))
                .tabItem{
                    Label("Profil", systemImage: "person.circle")
                }
        }.accentColor(.vertAccent)
            .tabViewStyle(.automatic)
    }
}
#Preview {
    ContentView()
}
