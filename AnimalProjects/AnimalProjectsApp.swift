//
//  AnimalProjectsApp.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import SwiftUI

@main
struct AnimalProjectsApp: App {
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(.vertDark.opacity(0.8))
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().tintColor = .white
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
