
//
//  ContentView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case calendar = "circle.grid.3x3"
    case discover = "safari"
    case search = "magnifyingglass"
    case account = "person.crop.circle"
    
    var title: String {
        switch self {
        case .calendar: return "Calendar"
        case .discover: return "Discover"
        case .search: return "Search"
        case .account: return "Account"
        }
    }
    
}

struct ContentView: View {
    
    @State private var selectedTab: Tab = .discover
    
    var body: some View {
        TabView(selection: Binding(
            get: { selectedTab },
            set: { newValue in
                selectedTab = newValue
                UIApplication.triggerHapticFeedback()
            }
        )) {
            YearView()
                .tag(Tab.calendar)
                .tabItem {
                    Image(systemName: Tab.calendar.rawValue)
                }
            
            DiscoverView()
                .tag(Tab.discover)
                .tabItem {
                    Image(systemName: Tab.discover.rawValue)
                }
            
            //            SearchView()
            //                .tag(Tab.search)
            //                .tabItem {
            //                    Image(systemName: Tab.search.rawValue)
            //                }
            
            AccountView()
                .tag(Tab.account)
                .tabItem {
                    Image(systemName: Tab.account.rawValue)
                }
        }
    }
}

