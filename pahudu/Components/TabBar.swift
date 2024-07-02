//
//  TabBar.swift
//  pahudu
//
//  Created by Wagner De Paula on 7/1/24.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Int
    let tabs: [String]
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                    UIApplication.triggerHapticFeedback()
                }) {
                    Text(tabs[index])
                        .font(.callout)
                        .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                        .background(selectedTab == index ? Colors.Primary.accent : Color.clear)
                        .foregroundColor(Colors.Primary.foreground)
                        .cornerRadius(15)
                }
            }
        }
    }
}
