//
//  ElevageCommunityView.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import SwiftUI

struct DiscussionListView: View {
    @State var vmDiscution = DiscussionViewModel()
    var category: CommunityCategory
    @State var listDisc: [DiscussionTopic] = []
    @State var searchText: String = ""
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                ScrollView {
                    
                    VStack(spacing: 16) {
                        
                        ForEach(listDisc, id: \.nomDiscussions) { topic in
                                DiscussionRow(topic: topic)
                        }
                        
                    }
                    .padding()
                }
                        
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Rechercher un groupe", text: $searchText)
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding()
                
            }
            .navigationTitle("Communauté")
            .background(Color.green.opacity(0.2))
        }.task {
            do {
                if !category.discutions.isEmpty {
                    for discID in category.discutions {
                        let d = try await vmDiscution.getDiscussion(discID)
                        listDisc.append(d)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

