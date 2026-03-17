//
//  SettingsRowView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 16/03/2026.
//

import SwiftUI

struct SettingsRowView: View {
    let icon: String
    let title: String
 
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(Color.vertAccent)
                .frame(width: 28)
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}


#Preview {
    SettingsRowView(icon: "person.circle", title: "Compte")
}
