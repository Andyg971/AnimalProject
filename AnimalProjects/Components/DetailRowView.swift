//
//  DetailRowView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 10/03/2026.
//

import SwiftUI

struct DetailRowView: View {
    let title: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.vertAccent)
            Text(value)
                .font(.system(size:16))
            
            Divider()
        }
        .padding()
    }
}

#Preview {
    DetailRowView(title: "Email", value: "pierre.martin@domaine.fr")
}
