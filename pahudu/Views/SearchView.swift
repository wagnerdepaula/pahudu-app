//
//  SearchView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/27/24.
//

import SwiftUI
import UIKit




struct SearchView: View {
    
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("SearchView")
                        .font(.headline)
                        //.foregroundColor(.primary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Search", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .scrollIndicators(.hidden)
            .background(Colors.Primary.background)
        }
    }
}
