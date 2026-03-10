//
//  SectionHeader.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct SectionHeader: View {

    let icon: String
    let color: Color
    let title: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)

            Text(title.uppercased())
                .font(.system(size: 16, weight: .bold))
        }
        .padding(.bottom, 4)
    }
}
