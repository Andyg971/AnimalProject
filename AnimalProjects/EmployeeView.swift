//
//  EmployeeView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import SwiftUI

struct EmployeeView: View {
    @State var viewModel = EmployeeViewModel()
    var body: some View {
        
        ZStack{
            Color.grisFond
            .ignoresSafeArea()
            
            NavigationStack {
               
                ScrollView(showsIndicators: false) {
                    LazyVStack() {
                        ForEach(viewModel.employees.sorted{$0.lastName < $1.lastName}) { employee in
                            NavigationLink{
                                EmployeeDetailView(employee: employee)
                            }
                            label: { HStack{
                                Image(systemName:"person")
                                    .frame(width:40)
                                VStack(alignment: .leading) {
                                    Text("\(employee.firstName) \(employee.lastName)")
                                        .font(.system(size: 20, weight: .bold))
                                    Text(employee.position)
                                        .font(.system(size:16))
                                }
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.vertAccent)
                            } .padding(24)
                                    .background(LinearGradient(
                                        colors: [
                                            .gray
                                                .opacity(0.1),
                                            .gray
                                                .opacity(0.3),
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing))
                                    .cornerRadius(16)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 4)
                                    .foregroundColor(.black)
                                
                            }
                        }
                        
                    }
                    
                    .task {
                        await viewModel.getEmployees()
                    }
                    
                }
                .navigationTitle("Employés")
                
                .toolbarBackground(.vertClair.opacity(0.8), for: .navigationBar)

                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
            
        }
        
    }
}
//
 


#Preview {
    EmployeeView()
}
