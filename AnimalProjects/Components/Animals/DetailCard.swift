//
//  DetailCard.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct DetailCard: View {
    let icon: String
    let color: Color
    let title: String
    let infoRows: [InfoRow]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)

                Text(title.uppercased())
                    .font(.system(size: 16, weight: .bold))
            }
            .padding(.bottom, 4)

            ForEach(infoRows) { infoRow in
                HStack {
                    Text(infoRow.label)
                    Spacer()
                    Text(infoRow.value).bold()
                }
            }

        }.frame(height: 100, alignment: .topLeading)
            .padding(16)
            .background(
                LinearGradient(
                    colors: [
                        .gray.opacity(0.1),
                        .gray.opacity(0.2),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            ).cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
    }
}
//#Preview {
//    DetailCard(
//        icon: "heart.fill",
//        color: .red,
//        title: "Exemple",
//        infoRows: reproductionRows
//    )
//}
