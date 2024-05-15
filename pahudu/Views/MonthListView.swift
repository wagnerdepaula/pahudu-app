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
    @State private var showDetails: Bool = false
    @State private var showDayView = false
    @State private var selectedShow: Show?
    
    var body: some View {
        eventList
            .navigationBarTitle(navBarTitle, displayMode: .inline)
            .background(Color("BackgroundColor"))
            .onChange(of: navBarTitle) { _, _ in
                UIApplication.triggerHapticFeedback()
            }
    }
    
    private var eventList: some View {
        List {
            ForEach(viewModel.monthsData, id: \.monthIndex) { monthData in
                itemListView(for: monthData)
                    .onAppear {
                        navBarTitle = "\(monthData.month) \(monthData.year)"
                    }
            }
            .background(Color("BackgroundColor"))
            .listRowBackground(Color("BackgroundColor"))
            .listRowSeparatorTint(Color("DividerColor"))
            .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .onTapGesture {
                showDayView = true
                UIApplication.triggerHapticFeedback()
            }
        }
        .background(Color("BackgroundColor"))
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showDayView) {
//            DayView(item: item)
//                .presentationDetents([.large])
//                .presentationCornerRadius(21)
            
        }
    }
    
    
    private func itemListView(for monthData: MonthData) -> some View {
        //        ForEach(Array(monthData.items.enumerated()), id: \.element.id) { index, item in
        //            DayCell(item: item, index: index, shows: item.shows) // Assumes `shows` are part of `item`
        //                .onTapGesture {
        //                    // Handle tap gestures
        //                    print(item)
        //                    UIApplication.triggerHapticFeedback()
        //                }
        //        }
        
        ForEach(Array(monthData.items.enumerated()), id: \.element.id) { index, item in
            if case let .date(dateItem) = item {
                
                //let shows = viewModel.showsForDate(item.dateItem)  // Ensure this is a method call
                
                //let shows =
                
                DayCell(item: item, index: index)
            }
        }
    }
}



// DayCell.swift
struct DayCell: View {
    let item: CalendarItem
    let index: Int
    //let shows: [Show]
    
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
                //showDetails
            }
            //.background(dateItem.isToday ? Color.white : alternateBackground)
        }
        //.padding(20)
    }
    
    private func dateLabel(_ dateItem: DateItem) -> some View {
        VStack(alignment: .center, spacing: 3) {
            Text(dateItem.dayOfWeek.description.uppercased())
                .caption()
                .foregroundColor(dateItem.isToday ? Color("BackgroundColor") : .primary)
            Text(dateItem.day.description)
                .numberLarge()
                .foregroundColor(dateItem.isToday ? Color("BackgroundColor") : .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //    private var showDetails: some View {
    //        ForEach(shows, id: \.id) { show in
    //            Text(show.brand.name)
    //            // Additional show details can be displayed here
    //        }
    //}
    
    private var alternateBackground: Color {
        index % 2 == 0 ? Color.white.opacity(0.1) : Color.clear
    }
}
