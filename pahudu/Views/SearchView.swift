//
//  SearchView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/27/24.
//

import SwiftUI
import UIKit



struct SearchView: View {
    
    @State private var selectedTab = 0
    let tabs = ["Home", "Profile", "Settings"]
    
    var body: some View {
        VStack {
            TabBar(selectedTab: $selectedTab, tabs: tabs)
            
            TabView(selection: $selectedTab) {
                Text("Home View").tag(0)
                Text("Profile View").tag(1)
                Text("Settings View").tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedTab)
        }
    }
}




