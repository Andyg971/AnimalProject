//
//  BudgetElevageView.swift
//  budgetdepenspets
//
//  Created by Apprenant 79 on 11/03/2026.
//

import SwiftUI
import Charts

struct BudgetElevageView: View {
    
    @State var budget: Double = +79000
    @State var depenses: [Depense] = depensesInitiales
    
    @State var triCroissant = true
    @State var showAdd = false
    
    
    var totalDepenses: Double {
        depenses.map{$0.total}.reduce(0,+)
    }
    
    var budgetRestant: Double {
        budget - totalDepenses
    }
    
    
    var depensesTriees: [Depense] {
        depenses.sorted {
            triCroissant ? $0.date < $1.date : $0.date > $1.date
        }
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    // depense et rapport
                    
                    VStack {
                        
                        Text("Budget élevage")
                            .font(.headline)
                        
                        Text("\(budgetRestant, specifier: "%.0f") € restant")
                            .font(.largeTitle)
                            .bold()
                        
                        Button("Modifier budget") {
                            budget += 500
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(15)
                    
                    
                    // tri
                    
                    Button {
                        triCroissant.toggle()
                    } label: {
                        Text(triCroissant ? "Tri ancien → récent" : "Tri récent → ancien")
                    }
                    
                    
                    // graphique et courbe representatif
                    
                    Chart(depensesTriees) { depense in
                        
                        BarMark(
                            x: .value("Catégorie", depense.categorie),
                            y: .value("Total", depense.total)
                        )
                        
                        LineMark(
                            x: .value("Catégorie", depense.categorie),
                            y: .value("Total", depense.total)
                        )
                        .interpolationMethod(.catmullRom)
                        
                    }
                    .frame(height: 250)
                    
                    
                    // camambers
                    
                    Chart(depenses) { depense in
                        
                        SectorMark(
                            angle: .value("Total", depense.total)
                        )
                        .foregroundStyle(by: .value("Catégorie", depense.categorie))
                        
                    }
                    .frame(height: 250)
                    
                    
                    // liste facturation
                    
                    VStack(alignment: .leading) {
                        
                        Text("Factures")
                            .font(.title2)
                            .bold()
                        
                        ForEach(depensesTriees) { depense in
                            
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
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                        }
                        
                    }
                    
                }
                .padding()
                
            }
            
            .navigationTitle("Gestion élevage")
            
            .toolbar {
                
                Button {
                    showAdd = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            
            .sheet(isPresented: $showAdd) {
                AjouterDepenseView(depenses: $depenses)
            }
        }
    }
}

#Preview {
    BudgetElevageView()
}
