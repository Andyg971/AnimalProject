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

        VStack(alignment: .leading, spacing: 6) {
            
                Text(topic.nomDiscussions)
                    .font(.headline)
           

                Text("\(topic.nbMessages) messages")
                    .font(.subheadline)
                    .padding(.bottom, 4)

            HStack {
                Text("Dernier message :")
                Text(topic.dernierCommentaire)
                    .bold()
                Text("le \(topic.formattedDate)")
            }

        }
        .font(.caption)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
    }
}
