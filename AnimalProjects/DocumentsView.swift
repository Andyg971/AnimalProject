//
//  DocumentsView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct DocumentsView: View {
    @State var viewModel = DocumentsViewModel()
    var body: some View {
        
        ZStack{

            Color.grisFond
            .ignoresSafeArea()
            
            NavigationStack {
               
                ScrollView(showsIndicators: false) {
                    LazyVStack() {
                        ForEach(viewModel.documents) { document in
                            HStack{
                                Image(systemName:"person")
                                    .frame(width:40)
                                VStack(alignment: .leading) {
                                    Text(document.title)
                                        .font(.system(size: 20, weight: .bold))
//                                    Text(document.size)
//                                        .font(.system(size:16))
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
                        do {
                           try await viewModel.getDocuments()
                        } catch {
                            print(error)
                        }
                    }
                    
                }
                .navigationTitle("Documents")
                
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)

                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
            
        }
        
    }
}
        
    


#Preview {
    DocumentsView()
}
