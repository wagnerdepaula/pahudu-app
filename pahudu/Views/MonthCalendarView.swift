//
//  MonthCalendarView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//

import SwiftUI

struct MonthCalendarView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
    @State var navBarTitle: String = "Pahudu"
    
//    @State var showDayView: Bool = false
//    @State private var selectedItem: CalendarItem?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
                    CalendarView(showDayView: $globalData.showDayView, items: viewModel.monthsData[monthIndex].items, monthIndex: viewModel.monthsData[monthIndex].monthIndex)
                        .id(viewModel.monthsData[monthIndex].monthIndex)
                }
            }
        }
        .background(Colors.Primary.background)
        
    }
    
    private func updateNavBarTitle() {
//        if let id = scrolledID, let monthData = viewModel.monthsData[safe: id] {
//            navBarTitle = "\(monthData.month) \(monthData.year)"
//        }
    }
}





struct CalendarView: View {
    
    @Binding var showDayView: Bool
    @State private var selectedItemId: UUID?
    @State private var selectedItem: CalendarItem?
    
    static let width = floor(UIScreen.main.bounds.width / 7.5) - 1
    let items: [CalendarItem]
    let monthIndex: Int
    
    
    var body: some View {
        
        let month: String =  DateFormatter().monthSymbols[monthIndex % 12]
        let currentMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1
        
        VStack(spacing: 0) {
            
            Text("\(month)")
               .font(.headline)
               .foregroundColor((currentMonthIndex ==  monthIndex) ? Colors.Primary.accent : Colors.Primary.foreground)
               .padding(EdgeInsets(top: 0, leading: 25, bottom: 5, trailing: 25))
               .frame(maxWidth: .infinity, minHeight: Self.width, alignment: .bottom)
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(Self.width), spacing: 0), count: 7), spacing: 0) {
                ForEach(items, id: \.id) { item in
                    
                    Button {
                        if selectedItemId == item.id {
                            showDayView = true
                        } else {
                            selectedItemId = item.id
                            selectedItem = item
                            showDayView = true
                            UIApplication.triggerHapticFeedback()
                        }
                    } label: {
                        CalendarCellView(item: item, isSelected: selectedItemId == item.id)
                    }
                    
                }
            }
            .fixedSize()
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
    private var circleWidth: CGFloat { width - 12 }
    private var cellWidth: CGFloat { width - 18 }
    
    var body: some View {
        Group {
            switch item {
            case .dayOfWeek(let day, _):
                
                Text(day)
                    .font(.callout)
                    .foregroundColor(Colors.Tertiary.foreground)
                    .frame(width: width, height: width)
                    
                
            case .date(let dateItem):
                ZStack {
                    if dateItem.isToday {
                        Circle()
                            .fill(Color.accentColor.opacity(0.3))
                            .frame(width: cellWidth, height: cellWidth)
                    } else if CalendarCellView.images[dateItem.day] != nil {
                        Circle()
                            .stroke(Colors.Primary.divider, style: StrokeStyle(lineWidth: 1.5, lineCap: .square))
                            .frame(width: cellWidth, height: cellWidth)
                    }
                    Text("\(dateItem.day)")
                        .font(.numberMedium)
                        .foregroundColor(dateItem.isToday ? Colors.Primary.accent : Colors.Primary.foreground)
                        .frame(width: width, height: width)
                    Circle()
                        .stroke(isSelected ? Colors.Primary.foreground : .clear, lineWidth: 1.5)
                        .frame(width: circleWidth, height: circleWidth)
                }
                .frame(width: width, height: width)
                .background(Colors.Primary.background)
            }
        }
    }
}
