
//
//  ContentView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI
import UIKit

enum Tab: String, CaseIterable {
    
    case calendar = "circle.grid.3x3"
    case discover = "globe.americas"
    case search = "magnifyingglass"
    case settings = "gear"
    
    var title: String {
        switch self {
        case .calendar: return "Calendar"
        case .discover: return "Discover"
        case .search: return "Search"
        case .settings: return "Settings"
        }
    }
}


struct ContentView: View {
    @State private var selectedTab: Tab = .calendar
    
    var body: some View {
        TabView(selection: $selectedTab) {
            YearView()
                .tabItem {
                    Label(Tab.calendar.title, systemImage: Tab.calendar.rawValue)
                }
                .tag(Tab.calendar)
            
            
            DiscoverView()
                .tabItem {
                    Label(Tab.discover.title, systemImage: Tab.discover.rawValue)
                }
                .tag(Tab.discover)
            
            SearchView()
                .tabItem {
                    Label(Tab.search.title, systemImage: Tab.search.rawValue)
                }
                .tag(Tab.search)
            
            SettingsView()
                .tabItem {
                    Label(Tab.settings.title, systemImage: Tab.settings.rawValue)
                }
                .tag(Tab.settings)
        }
    }
}

