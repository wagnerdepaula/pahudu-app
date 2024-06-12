
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
    
    @EnvironmentObject var globalData: GlobalData
    @State private var selectedTab: Tab = .calendar
    
    var tabSelection: Binding<Tab> {
        Binding(get: {
            selectedTab
        }, set: { newValue in
            if newValue == selectedTab {
                switch newValue {
                case .calendar: globalData.calendarStack = .init()
                case .discover: globalData.discoverStack = .init()
                case .search: globalData.searchStack = .init()
                case .account: globalData.accountStack = .init()
                }
            }
            selectedTab = newValue
        })
    }
    
    
    var body: some View {
        
        TabView(selection: tabSelection) {
            
            YearView()
                .tag(Tab.calendar)
                .tabItem {
                    Label(Tab.calendar.title, systemImage: Tab.calendar.rawValue)
                }
            
            
            DiscoverView()
                .tag(Tab.discover)
                .tabItem {
                    Label(Tab.discover.title, systemImage: Tab.discover.rawValue)
                }
                .onTapGesture {
                    print(tabSelection)
                }
            
            
            
            SearchView()
                .tag(Tab.search)
                .tabItem {
                    Label(Tab.search.title, systemImage: Tab.search.rawValue)
                }
            
            
            
            AccountView()
                .tag(Tab.account)
                .tabItem {
                    Label(Tab.account.title, systemImage: Tab.account.rawValue)
                }
            
        }
    }
    
    
    
    
}
