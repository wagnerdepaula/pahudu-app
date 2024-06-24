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
    
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    @Published var brands: [Brand] = []
    @Published var designers: [Designer] = []
    @Published var shows: [Show] = []
    
}



struct Constants {
    static let path: String = "https://storage.googleapis.com/pahudu.com"
}


