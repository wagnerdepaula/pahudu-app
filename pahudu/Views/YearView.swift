//
//  YearView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/11/24.
//

import SwiftUI

struct YearView: View {
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        NavigationStack {
            YearCalendarGridView()
        }
    }
}



struct YearCalendarGridView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var showDayView = false
    
    private static let width = floor(UIScreen.main.bounds.width / 23)
    
    private let columns = [
        GridItem(.flexible(), spacing: width, alignment: .top),
        GridItem(.flexible(), spacing: width, alignment: .top),
        GridItem(.flexible(), spacing: width, alignment: .top)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
                        Button(action: {
                            showDayView = true
                        }) {
                            MonthCalendarSmallView(
                                items: viewModel.monthsData[monthIndex].items,
                                monthIndex: viewModel.monthsData[monthIndex].monthIndex
                            )
                            .id(viewModel.monthsData[monthIndex].monthIndex)
                        }
                    }
                }
                .padding(MonthCalendarSmallView.width)
            }
        }
        .background(Colors.Primary.background)
        .navigationBarTitle("2024", displayMode: .inline)
        .navigationDestination(isPresented: $showDayView) {
            MonthView().presentationDetents([.large])
        }
    }
}



struct MonthCalendarSmallView: View {
    static let width = floor(UIScreen.main.bounds.width / 23)
    
    let items: [CalendarItem]
    let monthIndex: Int
    
    private var currentMonthIndex: Int {
        Calendar.current.component(.month, from: Date()) - 1
    }
    
    private var monthName: String {
        DateFormatter().shortMonthSymbols[monthIndex % 12]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(monthName)
                .font(.headline)
                .foregroundColor(currentMonthIndex == monthIndex ? Colors.Primary.accent : Colors.Primary.foreground)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(Self.width), spacing: 0), count: 7), spacing: 0) {
                ForEach(items, id: \.id) { item in
                    MonthCalendarCellSmallView(item: item)
                }
            }
        }
    }
}





struct MonthCalendarCellSmallView: View {
    let item: CalendarItem
    private let width: CGFloat = MonthCalendarSmallView.width
    private let circleWidth: CGFloat = MonthCalendarSmallView.width - 2
    
    var body: some View {
        Group {
            switch item {
            case .dayOfWeek:
                Text("")
                    .frame(width: width, height: 1)
                
            case .date(let dateItem):
                ZStack {
                    Text("\(dateItem.day)")
                        .font(.footnote)
                        .foregroundColor(dateItem.isToday ? Colors.Primary.accent : Colors.Primary.foreground)
                        .frame(width: width, height: width)
                }
                .frame(width: width, height: width)
            }
        }
    }
}
