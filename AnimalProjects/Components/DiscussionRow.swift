//
//  DiscussionRow.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import SwiftUI

struct DiscussionRow: View {
    
    var topic: DiscussionTopic
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 12) {
            
            Image(systemName: "person")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(topic.nomDiscussions)
                    .font(.headline)
                
                Text(topic.dernierscommentaire)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    
                    Text("\(topic.nombreMessage) messages")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(topic.date)
                        .font(.caption)
                }
                
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
    }
}
