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
                            NavigationLink {
                                DiscussionListView(category: category)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading){
                                        Text(category.title)
                                            .font(
                                                .system(size: 20, weight: .bold)
                                            ).padding(.bottom, 4)
                                        Text(category.description)
                                            .font(.system(size: 18))
                                    }
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                  
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.vertAccent)
                                }
                                .padding(16)
                                .background(.white)
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                                .padding(.horizontal, 16)
                                .foregroundColor(.black)
                            }
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
}

#Preview {
    CommunityView()
}
