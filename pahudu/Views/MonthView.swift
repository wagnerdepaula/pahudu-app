//
//  MonthView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//


import SwiftUI


struct MonthView: View {
    var monthIndex: Int
    var viewModel: CalendarViewModel
    var body: some View {
        CalendarView(items: viewModel.monthsData[monthIndex].items, monthIndex: monthIndex)
    }
}



struct CalendarView: View {
    
    @State private var showDayView = false
    @State private var selectedItemId: UUID?
    @State private var selectedIndex: Int?
    @State private var selectedItem: CalendarItem?
    
    static let width = floor(UIScreen.main.bounds.width / 7) - 1
    let items: [CalendarItem]
    let monthIndex: Int
    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(Self.width), spacing: 0), count: 7), spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                CalendarCellView(item: item, isSelected: selectedItemId == item.id)
                    .onTapGesture {
                        selectedIndex = index
                        selectedItem = item
                        selectedItemId = selectedItemId == item.id ? nil : item.id
                        showDayView = true
                        UIApplication.triggerHapticFeedback()
                    }
            }
        }
        .sheet(isPresented: $showDayView) {
            if let selectedItem = selectedItem {
                DayView(item: selectedItem)
                    .presentationDetents([.large])
                    .presentationCornerRadius(25)
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
    private var chartWidth: CGFloat { width - 20 }
    //private let gradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.accent, Color("ForegroundColor").opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    private let animation = Animation.timingCurve(0.8, 0.1, 0.5, 0.99, duration: 0.5)
    
    @State private var progress: CGFloat = 1.0
    
    
    var body: some View {
        
        Group {
            switch item {
                
            case .dayOfWeek(let day, _):
                
                Text(day)
                    .caption()
                    .foregroundColor(day == "S" ? Color("SecondaryColor") : Color("ForegroundColor"))
                    .frame(width: width, height: width)
                    .fixedSize()
                
                
            case .date(let dateItem):
                
                ZStack {
                    
                    if dateItem.isToday {
                        Circle()
                            .fill(Color("AccentColor"))
                            .frame(width: chartWidth, height: chartWidth)
                            .fixedSize()
                        
                    } else if let _ = CalendarCellView.images[dateItem.day] {
                        Circle()
                            .stroke(lineWidth: 2)
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .trim(from: 0, to: progress)
                                    .stroke(Color("AccentColor"), style: StrokeStyle(lineWidth: 2, lineCap: .square))
                                    .rotationEffect(Angle(degrees: -90))
                            )
                            .frame(width: chartWidth, height: chartWidth)
                            .fixedSize()
                        //                            .onAppear {
                        //                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(dateItem.day) * 0.1) {
                        //                                    withAnimation(animation) {
                        //                                        progress = 1
                        //                                    }
                        //                                }
                        //                            }
                        
                    }
                    
                    Text("\(dateItem.day)")
                        .numberMedium()
                        .foregroundColor(dateItem.isToday ? Color("BackgroundColor") : Color("ForegroundColor"))
                        .frame(width: width, height: width)
                        .fixedSize()
                    
                    Circle()
                        .stroke(isSelected ? Color("ForegroundColor") : .clear, lineWidth: 2)
                        .frame(width: circleWidth, height: circleWidth)
                        .fixedSize()
                    
                }
                .frame(width: width, height: width)
                .fixedSize()
            }
        }
    }
}

