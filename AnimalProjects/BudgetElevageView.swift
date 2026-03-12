//
//  BudgetElevageView.swift
//  budgetdepenspets
//
//  Created by Apprenant 79 on 11/03/2026.
//

import SwiftUI
import Charts

struct BudgetElevageView: View {
    
    let budget = 2500.0
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                //budget
                VStack {
                    
                    Text("Budget de l'élevage")
                        .font(.headline)
                    
                    Text("\(budget, specifier: "%.0f") €")
                        .font(.largeTitle)
                        .bold()
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(15)
                
                
              
                // Diagramme
                Chart(depenses) { depense in
                    
                    BarMark(
                        x: .value("Catégorie", depense.categorie),
                        y: .value("Total", depense.total)
                    )
                }
                .frame(height: 250)
                
                
                // Liste scrollante
                
                VStack(alignment: .leading) {
                    
                    Text("Dépenses détaillées")
                        .font(.title2)
                        .bold()
                    
                    ForEach(depenses) { depense in
                        
                        VStack(alignment: .leading) {
                            
                            Text(depense.categorie)
                                .font(.headline)
                            
                            HStack {
                                Text("Coût : \(depense.cout, specifier: "%.0f") €")
                                Spacer()
                                Text("Total : \(depense.total, specifier: "%.0f") €")
                                    .foregroundColor(.blue)
                            }
                            
                            Text("Date : \(depense.date)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                    }
                    
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    BudgetElevageView()
}
