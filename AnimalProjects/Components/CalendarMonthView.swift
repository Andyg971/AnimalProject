//
//  CalendarMonthView.swift
//  AnimalProjects
//
//  Created by apprenant79 on 16/03/2026.
//

import SwiftUI

struct CalendarMonthView: View {
    @State var selectedDate = Date()
    @State var viewModel = CalendarViewModel()
    var body: some View {

        VStack(spacing: 8) {
            HStack {
                Button(action: {
                    viewModel.displayedMonth = viewModel.calendar.date(
                        byAdding: .month,
                        value: -1,
                        to: viewModel.displayedMonth
                    )!
                }) {
                    Image(systemName: "chevron.left")
                        .padding(8)
                        .foregroundColor(.vertAccent)
                }

                Spacer()

                Text(viewModel.displayedMonth, format: Date.FormatStyle()
                                                .month(.wide)
                                                .locale(Locale(identifier: "fr_FR")))
                    .font(.system(size: 24, weight: .bold))

                Spacer()

                Button(action: {
                    viewModel.displayedMonth = viewModel.calendar.date(
                        byAdding: .month,
                        value: 1,
                        to: viewModel.displayedMonth
                    )!
                }) {
                    Image(systemName: "chevron.right")
                        .padding(8)
                        .foregroundColor(.vertAccent)
                }
            }
            .padding(.horizontal)

            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(viewModel.weekdays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.monthGrid, id: \.self) { day in
                    let dayEvents =
                        viewModel.eventsDict[
                            viewModel.calendar.startOfDay(for: day)
                        ] ?? []
                    let isCurrentMonth = viewModel.calendar.isDate(
                        day,
                        equalTo: viewModel.displayedMonth,
                        toGranularity: .month
                    )

                    VStack(spacing: 4) {
                        Text("\(viewModel.calendar.component(.day, from: day))")
                            .font(
                                .system(
                                    size: 16,
                                    weight: viewModel.calendar.isDateInToday(
                                        day
                                    ) ? .bold : .regular
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .foregroundColor(
                                viewModel.calendar.isDate(
                                    day,
                                    inSameDayAs: selectedDate
                                )
                                    ? .white
                                    : isCurrentMonth
                                        ? .black : .black.opacity(0.3)
                            )
                            .background(
                                viewModel.calendar.isDate(
                                    day,
                                    inSameDayAs: selectedDate
                                ) ? Color.vertAccent : Color.clear
                            )
                            .clipShape(Circle())

                        HStack(spacing: 2) {
                            ForEach(dayEvents.prefix(3)) { event in
                                Circle()
                                    .fill(event.color)
                                    .frame(width: 5, height: 5)
                            }
                        }
                    }
                    .onTapGesture {
                        selectedDate = day
                        if !isCurrentMonth {
                            viewModel.displayedMonth = day
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.grisFond))
        .cornerRadius(12)
    }
}
