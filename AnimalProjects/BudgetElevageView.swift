//
//  BudgetElevageView.swift
//  budgetdepenspets
//
//  Created by Apprenant 79 on 11/03/2026.
//

import SwiftUI
import Charts

struct BudgetElevageView: View {
    @State var vmDepenses = DepenseViewModel()
    
    @State var budget: Double = 79000
    
    @State var triCroissant = true
    @State var showAdd = false
    
    // mode sélection
    @State var modeSelection = false
    @State var selection = [String]()
    
    
    var totalDepenses: Double {
        vmDepenses.depenses.map{$0.total}.reduce(0,+)
    }
    
    var budgetRestant: Double {
        budget - totalDepenses
    }
    
    var depensesTriees: [Depense] {
        vmDepenses.depenses.sorted {
            triCroissant ? $0.date < $1.date : $0.date > $1.date
        }
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    // budget
                    
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
                    
                    
                    // graphique
                    
                    Chart(depensesTriees, id: \.categorie) { depense in
                        
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
                    
                    
                    // camembert
                    
                    Chart(vmDepenses.depenses, id: \.categorie) { depense in
                        
                        SectorMark(
                            angle: .value("Total", depense.total)
                        )
                        .foregroundStyle(by: .value("Catégorie", depense.categorie))
                        
                    }
                    .frame(height: 250)
                    
                    
                    // liste factures
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Text("Factures")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            // bouton sélectionner
                            
                            Button(modeSelection ? "Annuler" : "Sélectionner") {
                                modeSelection.toggle()
                                selection.removeAll()
                            }
                            
                        }
                        
                        ForEach(depensesTriees) { depense in
                            
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
                                
                                // ronds visibles seulement en mode sélection
                                
                                if modeSelection {
                                    
                                    Button {
                                        
                                        if selection.contains(depense.categorie) {
                                            selection.remove(depense.categorie)
                                        } else {
                                            selection.append(depense.categorie)
                                        }
                                        
                                    } label: {
                                        
                                        Image(systemName:
                                                selection.contains(depense.categorie)
                                              ? "checkmark.circle.fill"
                                              : "circle")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                        }
                        
                        
                        // bouton supprimer sélection
                        
                        if modeSelection && !selection.isEmpty {
                            
                            Button {
                                supprimerSelection()
                            } label: {
                                
                                Text("Supprimer \(selection.count) facture(s)")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(10)
                                
                            }
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
            
//            .sheet(isPresented: $showAdd) {
//                AjouterDepenseView(depenses: $depenses)
//            }
        }.task {
            do {
                try await vmDepenses.getDepensess()
            } catch {
                print(error)
            }
        }
    }
        
    
    
    func supprimerSelection() {
        
        vmDepenses.depenses.removeAll { depense in
            selection.contains(depense.categorie)
        }
        
        selection.removeAll()
        modeSelection = false
    }
}

#Preview {
    BudgetElevageView()
}
