//
//  FactureRowView.swift
//  AnimalProjects
//
//  Created by Ayoub ABARJI on 16/03/2026.
//

import SwiftUI

struct FactureRowView: View {
    let depense: Depense
    let isSelectionMode: Bool
    let isSelected: Bool
    let onToggleSelection: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(depense.categorie)
                    .font(.headline)
                
                HStack {
                    Text("Coût : \(depense.cout, specifier: "%.0f") €")
                    
                    Spacer()
                    
                    Text("Total : \(depense.total, specifier: "%.0f") €")
                        .foregroundColor(.blue)
                }
                
                Text("Date : \(depense.date.formatted())")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if isSelectionMode {
                Button {
                    onToggleSelection()
                } label: {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(16)
        .background(.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
