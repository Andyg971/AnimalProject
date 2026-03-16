//
//  MessageBubbleView.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 16/03/2026.
//

import SwiftUI

struct MessageBubbleView: View {
    
    var message: Message
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(message.text)
                
                Text(message.date.formatted())
                    .font(.caption2)
                    .foregroundColor(.gray)
                
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(15)
            
            Spacer()
        }
    }
}
