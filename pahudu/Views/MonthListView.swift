//
//  MonthListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/30/24.
//

import SwiftUI

struct MonthListView: View {
    
    @StateObject private var viewModel = CalendarViewModel()
    @State private var navBarTitle = "Events"
    @State private var showDayView = false
    @State private var selectedItem: CalendarItem?
    
    var body: some View {
        List {
            ForEach(viewModel.monthsData, id: \.monthIndex) { monthData in
                itemListView(for: monthData)
                    .onAppear {
                        navBarTitle = "\(monthData.month) \(monthData.year)"
                    }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .navigationBarTitle(navBarTitle, displayMode: .inline)
        .onChange(of: navBarTitle) { _, _ in
            UIApplication.triggerHapticFeedback()
        }
        .navigationDestination(isPresented: $showDayView, destination: {
            if let selectedItem = selectedItem {
                DayView(item: selectedItem)
                    .presentationDetents([.large])
            }
        })
    }
    
    private func itemListView(for monthData: MonthData) -> some View {
        ForEach(Array(monthData.items.enumerated()), id: \.element.id) { index, item in
            if case let .date(dateItem) = item {
                DayCell(item: item, index: index)
                    .onTapGesture {
                        selectedItem = item
                        showDayView = true
                        UIApplication.triggerHapticFeedback()
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("PrimaryDivider")),
            alignment: .bottom
        )
    }
}



struct DayCell: View {
    
    let item: CalendarItem
    let index: Int
    
    var body: some View {
        switch item {
        case .dayOfWeek:
            EmptyView()
        case .date(let dateItem):
            dateItemView(dateItem)
        }
    }
    
    private func dateItemView(_ dateItem: DateItem) -> some View {
        VStack(alignment: .leading) {
            HStack {
                dateLabel(dateItem)
                Spacer()
            }
        }
    }
    
    private func dateLabel(_ dateItem: DateItem) -> some View {
        VStack(alignment: .center, spacing: 3) {
            
            Text(dateItem.dayOfWeek.description.uppercased())
                .font(.caption)
                .kerning(0.5)
                .lineSpacing(0)
            
            Text(dateItem.day.description)
                .font(.numberLarge)
                .lineSpacing(0)
        }
        .frame(minWidth: 60, maxWidth: 60, maxHeight: .infinity, alignment: .center)
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .foregroundColor(Color.accentColor)
        .overlay(
            Rectangle()
                .frame(width: 0.5)
                .foregroundColor(Color("PrimaryDivider")),
            alignment: .trailing
        )
    }
}
