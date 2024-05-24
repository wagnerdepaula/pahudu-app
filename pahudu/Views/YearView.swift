//
//  YearView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//


import SwiftUI


struct YearView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CalendarViewModel()
    @State private var navBarTitle = "Fashion Calendar"
    @State var showCalendarView = true
    @State var selectedMenuOption: String = "calendar"
    
    var body: some View {
        NavigationStack {
            Group {
                if showCalendarView {
                    MonthCalendarView(viewModel: viewModel, navBarTitle: $navBarTitle)
                } else {
                    MonthListView()
                }
            }
            .navigationBarTitle(navBarTitle, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            showCalendarView.toggle()
                            selectedMenuOption = showCalendarView ? "rectangle.grid.1x2.fill" : "circle.grid.3x3.fill"
                        }
                        UIApplication.triggerHapticFeedback()
                    } label: {
                        Image(systemName: showCalendarView ? "rectangle.grid.1x2.fill" : "circle.grid.3x3.fill")
                    }
                }
            }
        }
    }
}




struct MonthCalendarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CalendarViewModel
    @State var scrolledID: Int?
    @Binding var navBarTitle: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.monthsData.indices, id: \.self) { monthIndex in
                        MonthView(monthIndex: monthIndex, viewModel: viewModel)
                            .id(viewModel.monthsData[monthIndex].monthIndex)
                            .frame(height: geo.size.height + geo.safeAreaInsets.top, alignment: .top)
                            .padding(.bottom, geo.safeAreaInsets.bottom)
                    }
                    .drawingGroup()
                }
                .scrollTargetLayout()
                .padding(EdgeInsets(top: geo.safeAreaInsets.top, leading: 0, bottom: -geo.safeAreaInsets.top, trailing: 0))
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $scrolledID)
            .environmentObject(viewModel)
            .onAppear {
                let monthData = viewModel.monthsData[scrolledID ?? 0]
                navBarTitle = "\(monthData.month) \(monthData.year)"
            }
            .onChange(of: scrolledID) { new, old in
                if let _ = new {
                    UIApplication.triggerHapticFeedback()
                }
                if let old = old {
                    let monthData = viewModel.monthsData[old]
                    navBarTitle = "\(monthData.month) \(monthData.year)"
                }
            }
            .ignoresSafeArea(.container, edges: [.top, .bottom])
            .environmentObject(viewModel)
        }
    }
}
