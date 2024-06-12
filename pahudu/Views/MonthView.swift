//
//  MonthView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//


import SwiftUI

struct MonthView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CalendarViewModel()
    
    @State private var navBarTitle = "2024"
    @State private var showCalendarView = true
    @State private var selectedMenuOption: String = "calendar"
    
     
    var body: some View {
        NavigationStack {
            Group {
                if showCalendarView {
                    MonthCalendarView()
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
                            selectedMenuOption = showCalendarView ? "calendar.day.timeline.left" : "calendar"
                        }
                        UIApplication.triggerHapticFeedback()
                    } label: {
                        Image(systemName: showCalendarView ? "calendar.day.timeline.left" : "calendar")
                    }
                }
            }
            .background(Colors.Primary.background)
        }
        .navigationDestination(isPresented: $globalData.showDayView) {
            DayView()
        }
        
    }
}





