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
        HStack(spacing: 16) {
            Image(systemName: "bubble.left.fill")
                .font(.system(size: 18))
                .foregroundStyle(.blue)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(topic.nomDiscussions)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text("\(topic.nbMessages) messages")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.vertAccent)
                
                HStack {
                    Text("Dernier message de")
                    Text(topic.dernierCommentaire).bold()
                    Text(topic.formattedDate)
                }
                .font(.system(size: 13))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.vertAccent)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
