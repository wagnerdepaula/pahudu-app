//
//  DesignersListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignerRowView: View {
    
    let item: DesignerItem
    let color: Color = Colors.Primary.divider
    
    var body: some View {
        
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .background(Colors.Secondary.foreground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 0.5)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.body)
                
                Text(item.subtitle)
                    .foregroundColor(Colors.Tertiary.foreground)
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .overlay(
            Divider(),
            alignment: .bottom
        )
    }
}





struct DesignersListView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(GlobalData.designers) { item in
                        DesignerRowView(item: item)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarTitle("Designers", displayMode: .inline)
            .background(Colors.Primary.background)
        }
    }
}
