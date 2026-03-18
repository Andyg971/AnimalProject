//
//  CommunityView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct CommunityView: View {
    @State var viewModel = CommunityViewModel()
    @State private var search = ""
    var filteredCategory: [CommunityCategory] {
        if search.isEmpty {
            return viewModel.communityCategory
        } else {
            return viewModel.communityCategory.filter {
                $0.title.localizedCaseInsensitiveContains(search)
                    || $0.description.localizedCaseInsensitiveContains(search)
            }
        }
    }
    var body: some View {

        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            NavigationStack {

                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(filteredCategory) { category in
                            let style = communityStyle(for: category.title)
                            
                            NavigationLink {
                                DiscussionListView(category: category)
                            } label: {
                                HStack(spacing: 14) {
                                    Image(systemName: style.icon)
                                        .font(.system(size: 18))
                                        .foregroundStyle(style.color)
                                        .frame(width: 42, height: 42)
                                        .background(style.color.opacity(0.2))
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(category.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.primary)
                                        
                                        Text(category.description)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("\(category.threadNumber) discussions")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.vertAccent)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.vertAccent)
                                }
                                .padding(16)
                                .background(.white)
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                                .padding(.horizontal, 16)
                            }
                            .buttonStyle(.plain)
                        }

                    }

                    .task {
                        await viewModel.getcommunityCategory()
                    }

                }
                .navigationTitle("Communauté")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search, prompt: "Rechercher un groupe")
            }

        }

    }
    
    func communityStyle(for title: String) -> (icon: String, color: Color) {
        let t = title.lowercased()
        
        if t.contains("santé") || t.contains("vétérinaire") || t.contains("soin") {
            return ("cross.case.fill", .red)
        }
        if t.contains("alimentation") || t.contains("nutrition") || t.contains("fourrage") {
            return ("leaf.fill", .green)
        }
        if t.contains("reproduction") || t.contains("élevage") || t.contains("naissance") {
            return ("heart.fill", .pink)
        }
        if t.contains("marché") || t.contains("vente") || t.contains("commerce") {
            return ("cart.fill", .orange)
        }
        if t.contains("équipement") || t.contains("matériel") || t.contains("outil") {
            return ("wrench.and.screwdriver.fill", .indigo)
        }
        if t.contains("météo") || t.contains("climat") || t.contains("saison") {
            return ("cloud.sun.fill", .cyan)
        }
        if t.contains("conseil") || t.contains("astuce") || t.contains("aide") {
            return ("lightbulb.fill", .yellow)
        }
        if t.contains("général") || t.contains("discussion") || t.contains("bavardage") {
            return ("bubble.left.and.bubble.right.fill", .purple)
        }
        
        return ("bubble.left.fill", .blue)
    }
}

#Preview {
    CommunityView()
}
