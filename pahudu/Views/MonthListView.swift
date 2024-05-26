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
            .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .navigationBarTitle(navBarTitle, displayMode: .inline)
        .onChange(of: navBarTitle) { _, _ in
            UIApplication.triggerHapticFeedback()
        }
        .sheet(isPresented: $showDayView) {
            if let selectedItem = selectedItem {
                DayView(item: selectedItem)
                    .presentationDetents([.large])
                    .presentationCornerRadius(25)
            }
        }
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
                .caption()
            Text(dateItem.day.description)
                .numberLarge()
        }
        .frame(width: 60, height: 60, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.accentColor)
        )
        .foregroundColor(Color("BackgroundColor"))
    }
}
