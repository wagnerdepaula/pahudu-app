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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showCalendarView = true
                            selectedMenuOption = "calendar"
                            UIApplication.triggerHapticFeedback()
                        }) {
                            HStack {
                                Text("Calendar")
                                Spacer()
                                Image(systemName: "calendar")
                            }
                        }
                        Button(action: {
                            showCalendarView = false
                            selectedMenuOption = "calendar.day.timeline.left"
                            UIApplication.triggerHapticFeedback()
                        }) {
                            HStack {
                                Text("Schedule")
                                Spacer()
                                Image(systemName: "calendar.day.timeline.left")
                            }
                        }
                    } label: {
                        Image(systemName: selectedMenuOption)
                            .imageScale(.large)
                            .foregroundColor(Colors.Primary.accent)
                    }
                }
            }
            
            
            .navigationBarTitle(navBarTitle, displayMode: .inline)
            .background(Colors.Primary.background)
        }
        .navigationDestination(isPresented: $globalData.showDayView) {
            DayView()
        }
        
    }
}





