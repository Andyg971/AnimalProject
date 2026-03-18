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
        HStack(spacing: 14) {
            Image(systemName: "bubble.left.fill")
                .font(.system(size: 18))
                .foregroundStyle(.blue)
                .frame(width: 42, height: 42)
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(topic.nomDiscussions)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text("\(topic.nbMessages) discussions")
                    .font(.system(size: 13))
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
    }
}
