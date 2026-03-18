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
    let symbol: String
    let symbolColor: Color
    let title: String
    let infoRows: [InfoRow]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)

                    Text(title.uppercased())
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Image(systemName: symbol)
                        .foregroundColor(symbolColor)
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
            Image(systemName: "chevron.right")
                .foregroundColor(.vertAccent)
                .padding(.leading, 8)

        }
        .padding(16)
        .background(
            .white
            )
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
#Preview {
    DetailCard(
        icon: "heart.fill",
        color: .red,
        symbol: "chevron.right",
        symbolColor: .clear,
        title: "Exemple",
        infoRows: reproductionRows
    )
}
