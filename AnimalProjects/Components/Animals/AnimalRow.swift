//
//  AnimalRow.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct AnimalRow: View {
    let animal: Animal
    var body: some View {
        HStack {
            if let url = animal.photo?.first?.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
            } else {

                Image(systemName: "pawprint")
                    .frame(width: 40)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("\(animal.id)")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Text(animal.name ?? "")
                    Spacer()
                }
                Text("\(animal.species.rawValue) (\(animal.race))")
                    .font(.system(size: 16))
            }

            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.vertAccent)
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [
                    .gray.opacity(0.1),
                    .gray.opacity(0.3),
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}
#Preview {
    AnimalRow(animal: animalTest)
}
