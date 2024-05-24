
//
//  ContentView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI
import UIKit

// Example usage in a SwiftUI view

struct ContentView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            YearView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                    Text("Calendar")
                }
                .tag(0)
            
            DiscoverView()
                .tabItem {
                    Image(systemName: "square.stack")
                    Text("Discover")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}


