//
//  InfoRow.swift
//  AnimalProjects
//
//  Created by apprenant79 on 10/03/2026.
//

import SwiftUI

struct InfoRow: View {

    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value).bold()
        }
    }
}
