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
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer()
                    Text("DiscoverView")
                        .font(.headline)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .navigationBarTitle("Discover", displayMode: .inline)
            .background(Color("PrimaryBackground"))
        }
    }
    
}
