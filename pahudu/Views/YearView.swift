//
//  YearView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/11/24.
//

import SwiftUI

struct YearView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CalendarViewModel()
    @State private var navBarTitle = "Pahudu"
    @State private var showCalendarView = true
    @State private var selectedMenuOption: String = "calendar"
    
    var body: some View {
        NavigationStack {
            YearCalendarGridView()
                .navigationBarTitle(navBarTitle, displayMode: .inline)
                .background(Colors.Primary.background)
        }
        
    }
}




struct YearCalendarGridView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
    @State private var scrolledID: Int?
    @State var navBarTitle: String = "Pahudu"
    
    @State private var showDayView = false
    @State private var selectedItemId: UUID?
    @State private var selectedItem: CalendarItem?
    
    let columns = [
        GridItem(.flexible(), spacing: MonthCalendarSmallView.width, alignment: .top),
        GridItem(.flexible(), spacing: MonthCalendarSmallView.width, alignment: .top),
        GridItem(.flexible(), spacing: MonthCalendarSmallView.width, alignment: .top)
    ]
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
                        MonthCalendarSmallView(items: viewModel.monthsData[monthIndex].items, monthIndex: viewModel.monthsData[monthIndex].monthIndex)
                            .id(viewModel.monthsData[monthIndex].monthIndex)
                            .onTapGesture {
                                showDayView = true
                                UIApplication.triggerHapticFeedback(style: .light)
                            }
                    }
                }
                .padding(MonthCalendarSmallView.width)
            }
        }
        .background(Colors.Primary.background)
        .navigationDestination(isPresented: $showDayView) {
            MonthView()
                .presentationDetents([.large])
        }
    }



    
    
}







struct MonthCalendarSmallView: View {
    
    
    static let width = floor(UIScreen.main.bounds.width / 25)
    let items: [CalendarItem]
    let monthIndex: Int
    
    
    var body: some View {
        
        let month: String =  DateFormatter().shortMonthSymbols[monthIndex % 12]
        
        VStack(spacing: 0) {
            
            Text(month)
                .font(.callout)
                .foregroundColor(Colors.Primary.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(Self.width), spacing: 0), count: 7), spacing: 0) {
                ForEach(items, id: \.id) { item in
                    MonthCalendarCellSmallView(item: item)
                }
                
            }
            
            //.fixedSize()
        }

    }
}






struct MonthCalendarCellSmallView: View {
    
    let item: CalendarItem
    private let width: CGFloat = MonthCalendarSmallView.width
    
    var body: some View {
        Group {
            switch item {
            case .dayOfWeek(_ , _):
                
                Text("")
                    .frame(width: width, height: width)
                
            case .date(let dateItem):
                ZStack {
                    
                    if dateItem.isToday {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: width, height: width)
                    }
                    
                    Text("\(dateItem.day)")
                        .font(.footnote)
                        .foregroundColor(Colors.Primary.foreground)
                        .frame(width: width, height: width)

                }
                .frame(width: width, height: width)
                
            }
        }
        
    }
}
