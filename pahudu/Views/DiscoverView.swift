//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


struct DiscoverView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("DiscoverView")
                        .headline()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Discover", displayMode: .inline)
            .scrollIndicators(.hidden)
        }
    }
    
}
