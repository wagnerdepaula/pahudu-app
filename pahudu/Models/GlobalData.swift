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
    
    @Published private(set) var recentItems: [AnyHashable] = []
    
    func addRecentItem<T: Hashable>(_ item: T) {
        // Remove the item if it already exists
        recentItems.removeAll { $0 as? T == item }
        
        // Add the new item at the beginning of the array
        recentItems.insert(item as AnyHashable, at: 0)
        
        // Ensure the array doesn't exceed 10 items
        if recentItems.count > 10 {
            recentItems.removeLast()
        }
        
        objectWillChange.send()
    }
    
}



struct Path {
    static let shows: String = "https://storage.googleapis.com/pahudu.com/shows"
    static let brands: String = "https://storage.googleapis.com/pahudu.com/brands"
    static let designers: String = "https://storage.googleapis.com/pahudu.com/designers"
}


