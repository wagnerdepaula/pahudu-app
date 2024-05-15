//
//  SearchView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/27/24.
//

import SwiftUI


struct SearchView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("SearchView")
                        .headline()
                        .foregroundColor(.primary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .navigationTitle("Search")
            .scrollIndicators(.hidden)
        }
    }
    
}
