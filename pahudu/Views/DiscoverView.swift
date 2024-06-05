//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


struct DiscoverItemView: View {
    
    let item: DesignerItem
    @Binding var showList: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 110, height: 110)
                .background(Colors.Tertiary.background)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Colors.Primary.accent, lineWidth: 1)
                )
            Text(item.title)
                .font(.caption)
                .foregroundColor(Colors.Secondary.foreground)
        }
        .onTapGesture {
            showList = true
            UIApplication.triggerHapticFeedback()
        }
    }
}

struct DiscoverView: View {
    @State private var showList = false
    
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
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(items) { item in
                                DiscoverItemView(item: item, showList: $showList)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Colors.Primary.divider),
                    alignment: .bottom
                )
            }
            .navigationBarTitle("Discover", displayMode: .inline)
            .background(Colors.Primary.background)
            .navigationDestination(isPresented: $showList) {
                DesignersView()
            }
        }
    }
}
