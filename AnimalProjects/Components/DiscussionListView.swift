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

        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            VStack {

                ScrollView {

                    VStack(spacing: 16) {

                        ForEach(listDisc, id: \.nomDiscussions) { topic in
                            DiscussionRow(topic: topic)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(category.title)
            
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
