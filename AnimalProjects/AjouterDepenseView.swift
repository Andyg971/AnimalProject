//
//  AjouterDepenseView.swift
//  AnimalProjects
//
//  Created by Apprenant 79 on 12/03/2026.
//

import SwiftUI

struct AjouterDepenseView: View {
    
    @Binding var depenses: [Depense]
    
    @State var categorie = ""
    @State var cout = ""
    @State var quantite = ""
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                TextField("Catégorie", text: $categorie)
                
                TextField("Coût", text: $cout)
                    .keyboardType(.decimalPad)
                
                TextField("Quantité", text: $quantite)
                    .keyboardType(.decimalPad)
                
            }
            
            .navigationTitle("Nouvelle facture")
            
            .toolbar {
                
                Button("Ajouter") {
                    
                    let c = Double(cout) ?? 0
                    let q = Double(quantite) ?? 0
                    
                    let nouvelleDepense = Depense(
                        categorie: categorie,
                        cout: c,
                        quantite: q,
                        total: c*q,
                        date: Date()
                    )
                    
                    depenses.append(nouvelleDepense)
                    
                    dismiss()
                }
            }
        }
    }
}
