//
//  EmployeeView.swift
//  AnimalProjects
//
//  Created by Julia Canovas on 09/03/2026.
//

import SwiftUI

struct EmployeeView: View {
    @State var viewModel = EmployeeViewModel()
    @State private var search = ""
    var filteredEmployees: [Employee] {
        if search.isEmpty {
            return viewModel.employees.sorted { $0.lastName < $1.lastName }
        } else {
            return viewModel.employees
                .filter {
                    $0.firstName.localizedCaseInsensitiveContains(search)
                        || $0.lastName.localizedCaseInsensitiveContains(search)
                        || $0.position.localizedCaseInsensitiveContains(search)
                }
                .sorted { $0.lastName < $1.lastName }
        }
    }
    var body: some View {

        ZStack {
            Color.grisFond
                .ignoresSafeArea()

            NavigationStack {

                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(filteredEmployees) { employee in

                            NavigationLink {
                                EmployeeDetailView(employee: employee)
                            } label: {
                                HStack {
                                    if let url = employee.photo?.first?.url {
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
                                        Image(systemName: "person")
                                            .frame(width: 40)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(
                                            "\(employee.firstName) \(employee.lastName)"
                                        )
                                        .font(.system(size: 20, weight: .bold))
                                        Text(employee.position)
                                            .font(.system(size: 16))
                                    }

                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.vertAccent)
                                }
                                .padding(16)
                                .background(.white)
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                                .padding(.horizontal, 16)
                                .foregroundColor(.black)

                            }
                        }

                    }

                    .task {
                        await viewModel.fetchEmployees()
                    }

                }
                .navigationTitle("Employés")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search, prompt: "Rechercher un employé")

            }

        }

    }
}
#Preview {
    EmployeeView()
}
