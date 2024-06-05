//
//  DesignersView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignerItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

struct DesignerRowView: View {
    let item: DesignerItem
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .frame(width: 70, height: 70)
                .background(Colors.Primary.foreground)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 7) {
                Text(item.title)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.body)
                
                Text(item.subtitle)
                    .foregroundColor(Colors.Secondary.foreground)
                    .font(.caption)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Colors.Primary.divider),
            alignment: .bottom
        )
    }
}

struct DesignersView: View {
    
    let items: [DesignerItem] = [
        DesignerItem(imageName: "Caroline Zimbalist", title: "Caroline Zimbalist", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Colleen Allen", title: "Colleen Allen", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Jacques Agbobly", title: "Jacques Agbobly", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Kate Barton", title: "Kate Barton", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Nigel Xavier", title: "Nigel Xavier", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Paolo Carzana", title: "Paolo Carzana", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Jane Wade", title: "Jane Wade", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Ludovic de Saint Sernin", title: "Ludovic de Saint Sernin", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Bishme Cromartie", title: "Bishme Cromartie", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Meruert Tolegen", title: "Meruert Tolegen", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Yitao Li", title: "Yitao Li", subtitle: "Fashion Designer"),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(items) { item in
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
