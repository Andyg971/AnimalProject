//
//  DiscussionRow.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import SwiftUI

struct DiscussionRow: View {

    var topic: DiscussionTopic
    let cat: CommunityCategory
    var body: some View {
        HStack{
            
            let style = communityStyle(for: cat.title)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: style.icon)
                        .font(.system(size: 18))
                        .foregroundStyle(style.color)
                        .frame(width: 24, height: 24)
                    
                    Text(topic.nomDiscussions)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Text("\(topic.nbMessages) messages")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.vertAccent)

                Text("Dernier message de \(Text(topic.dernierCommentaire).bold()) \(topic.formattedDate)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.vertAccent)
                .padding(.leading, 8)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
