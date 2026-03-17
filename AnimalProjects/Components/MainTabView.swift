//
//  MainTabView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 17/03/2026.
//

import SwiftUI

struct MainTabView: View {
    init() {
    
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "grisFond")
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named:"vertAccent")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.vertAccent]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            
//            DashboardView()
//                .tabItem{
//                    Label("Documents", systemImage: "doc.fill")
//
//                }
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
    MainTabView()
}
