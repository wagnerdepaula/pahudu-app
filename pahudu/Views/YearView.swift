//
//  YearView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/11/24.
//

import SwiftUI

struct YearView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack() {
            YearCalendarGridView()
        }
    }
}




struct YearCalendarGridView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
    @State private var scrolledID: Int?
    @State var navBarTitle: String = "2024"
    
    
    @State private var showDayView = false
    @State private var selectedItemId: UUID?
    @State private var selectedItem: CalendarItem?
    
    static let width = floor(UIScreen.main.bounds.width / 23)
    
    let columns = [
        GridItem(.flexible(), spacing: width, alignment: .top),
        GridItem(.flexible(), spacing: width, alignment: .top),
        GridItem(.flexible(), spacing: width, alignment: .top)
    ]
    

    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
//                        if monthIndex % 12 == 0 {
//                            Text(viewModel.monthsData[monthIndex].year)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }

                        Button {
                            showDayView = true
                        } label: {
                            MonthCalendarSmallView(items: viewModel.monthsData[monthIndex].items, monthIndex: viewModel.monthsData[monthIndex].monthIndex)
                                .id(viewModel.monthsData[monthIndex].monthIndex)
                        }
                    }
                }
                .padding(MonthCalendarSmallView.width)
            }
        }
        .background(Colors.Primary.background)
        .navigationBarTitle(navBarTitle, displayMode: .inline)
        .navigationDestination(isPresented: $showDayView) {
            MonthView()
                .presentationDetents([.large])
        }
    }




    
    
}







struct MonthCalendarSmallView: View {
    
    
    static let width = floor(UIScreen.main.bounds.width / 23)
    let items: [CalendarItem]
    let monthIndex: Int
    let currentMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1
    
    
    var body: some View {
        
        let month: String =  DateFormatter().shortMonthSymbols[monthIndex % 12]
    
        
        VStack(spacing: 0) {
            
            Text(month)
                .font(.headline)
                .foregroundColor((currentMonthIndex ==  monthIndex) ? Colors.Primary.accent : Colors.Primary.foreground)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
            case .dayOfWeek(_ , _):
                
                Text("")
                    .frame(width: width, height: width)
                
            case .date(let dateItem):
                ZStack {
                    
                    Text("\(dateItem.day)")
                        .font(.footnote)
                        .kerning(0.3)
                        .foregroundColor(dateItem.isToday ? Colors.Primary.accent : Colors.Primary.foreground)
                        .frame(width: width, height: width)

                }
                .frame(width: width, height: width)
                
            }
        }
        
    }
}
