//
//  MonthCalendarView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//

import SwiftUI



struct MonthCalendarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
    @State private var scrolledID: Int?
    @State var navBarTitle: String = "Pahudu"
    static let height = floor(UIScreen.main.bounds.width / 7) - 1
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
                    CalendarView(items: viewModel.monthsData[monthIndex].items, monthIndex: viewModel.monthsData[monthIndex].monthIndex)
                        .id(viewModel.monthsData[monthIndex].monthIndex)
                }
            }
        }
        .onAppear {
            updateNavBarTitle()
        }
        .onChange(of: scrolledID) { _ in
            updateNavBarTitle()
        }
        .background(Color("PrimaryBackground"))
    }
    
    private func updateNavBarTitle() {
//        if let id = scrolledID, let monthData = viewModel.monthsData[safe: id] {
//            navBarTitle = "\(monthData.month) \(monthData.year)"
//        }
    }
}





struct CalendarView: View {
    
    @State private var showDayView = false
    @State private var selectedItemId: UUID?
    @State private var selectedItem: CalendarItem?
    
    static let width = floor(UIScreen.main.bounds.width / 7) - 1
    let items: [CalendarItem]
    let monthIndex: Int
    
    
    var body: some View {
        
        let month: String =  DateFormatter().monthSymbols[monthIndex % 12]
        
        VStack(spacing: 0) {
            Text(month)
               .font(.headline)
               .foregroundColor(Color("PrimaryAccent"))
               .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
               .frame(maxWidth: .infinity, minHeight: Self.width, alignment: .bottomLeading)
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(Self.width), spacing: 0), count: 7), spacing: 0) {
                ForEach(items, id: \.id) { item in
                    CalendarCellView(item: item, isSelected: selectedItemId == item.id)
                        .onTapGesture {
                            if selectedItemId == item.id {
                                showDayView = true
                            } else {
                                selectedItemId = item.id
                                selectedItem = item
                                showDayView = true
                                UIApplication.triggerHapticFeedback()
                            }
                        }
                }
            }
            .fixedSize()
        }
        .navigationDestination(isPresented: $showDayView) {
            if let selectedItem = selectedItem {
                DayView(item: selectedItem)
                    .presentationDetents([.large])
            }
        }
    }
}



struct CalendarCellView: View {
    
    let item: CalendarItem
    let isSelected: Bool
    
    private static let images: [Int: String] = [
        12: "Louis Vuitton",
        14: "Lacoste",
        15: "Miu Miu",
        19: "Zomer",
        23: "Chanel",
        25: "Marine Serre"
    ]
    private let width: CGFloat = CalendarView.width
    private var circleWidth: CGFloat { width - 14 }
    private var cellWidth: CGFloat { width - 20 }
    
    var body: some View {
        Group {
            switch item {
            case .dayOfWeek(let day, _):
                
                Text(day)
                    .font(.callout)
                    .foregroundColor(Color("TertiaryBackground"))
                    .frame(width: width, height: width)
                    
                
                
            case .date(let dateItem):
                ZStack {
                    if dateItem.isToday {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: cellWidth, height: cellWidth)
                    } else if CalendarCellView.images[dateItem.day] != nil {
                        Circle()
                            .stroke(Color("TertiaryBackground"), style: StrokeStyle(lineWidth: 1.5, lineCap: .square))
                            .frame(width: cellWidth, height: cellWidth)
                    }
                    Text("\(dateItem.day)")
                        .font(.numberMedium)
                        .foregroundColor(dateItem.isToday ? Color("PrimaryBackground") : Color("PrimaryText"))
                        .frame(width: width, height: width)
                    Circle()
                        .stroke(isSelected ? Color("PrimaryText") : .clear, lineWidth: 1.5)
                        .frame(width: circleWidth, height: circleWidth)
                }
                .frame(width: width, height: width)
                .background(Color("PrimaryBackground"))
            }
        }
    }
}
