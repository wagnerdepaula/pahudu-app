//
//  GlobalData.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/11/24.
//

import SwiftUI
import Combine

class GlobalData: ObservableObject {
    
    @Published var showDayView: Bool = false
    @Published var selectedCalendarItem: CalendarItem?
    
    @Published var calendarStack: NavigationPath = .init()
    @Published var discoverStack: NavigationPath = .init()
    @Published var searchStack: NavigationPath = .init()
    @Published var accountStack: NavigationPath = .init()
    
    
}
