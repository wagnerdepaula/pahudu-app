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
    @State private var selectedMenuOption: String = "circle.grid.3x3.fill"
    
    
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
                            selectedMenuOption = "circle.grid.3x3.fill"
                            UIApplication.triggerHapticFeedback()
                        }) {
                            HStack {
                                Text("Calendar")
                                Spacer()
                                Image(systemName: "circle.grid.3x3.fill")
                            }
                        }
                        Button(action: {
                            showCalendarView = false
                            selectedMenuOption = "rectangle.grid.1x2.fill"
                            UIApplication.triggerHapticFeedback()
                        }) {
                            HStack {
                                Text("Schedule")
                                Spacer()
                                Image(systemName: "rectangle.grid.1x2.fill")
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





