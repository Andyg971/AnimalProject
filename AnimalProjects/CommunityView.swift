//
//  CommunityView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct CommunityView: View {
    @State var viewModel = CommunityViewModel()
    var body: some View {
        
        ZStack{
            
//            LinearGradient(
//                                colors: [
//                                    Color.grisFond.opacity(0.99),
//                                    Color.grisFond.opacity(0.8)
//                                ],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
            Color.grisFond
            .ignoresSafeArea()
            
            NavigationStack {
               
                ScrollView(showsIndicators: false) {
                    LazyVStack() {
                        ForEach(viewModel.communityCategory) { category in
                            HStack{
                                Image(systemName:"person")
                                    .frame(width:40)
                                VStack(alignment: .leading) {
                                    Text(category.title)
                                        .font(.system(size: 20, weight: .bold))
                                    Text(category.description)
                                        .font(.system(size:16))
                                }
                                Spacer()
                                
                            } .padding(24)
                                .background(LinearGradient(
                                    colors: [
                                        .gray
                                            .opacity(0.1),
                                        .gray
                                            .opacity(0.3),
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing))
                                .cornerRadius(16)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                            
                                
                        }
                        
                    }
                    
                    .task {
                        await viewModel.getcommunityCategory()
                    }
                    
                }
                .navigationTitle("Community")
                
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)

                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
            
        }
        
    }
}
    


#Preview {
    CommunityView()
}
