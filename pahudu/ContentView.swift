
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
                    Image(systemName: "circle.grid.3x3.fill")
                    Text("Calendar")
                }
                .tag(0)
            
            DiscoverView()
                .tabItem {
                    Image(systemName: "safari.fill")
                    Text("Discover")
                }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .onChange(of: selectedTab) { new, old in
            UIApplication.triggerHapticFeedback(style: .soft)
        }
    }

}


