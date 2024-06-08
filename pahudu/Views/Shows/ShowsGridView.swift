//
//  ShowsGridView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct ShowGridItemView: View {
    
    let item: ShowItem
    @State var showShowsList: Bool = false
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Colors.Primary.divider, lineWidth: 0.5)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.caption)
                
                Text(item.subtitle)
                    .foregroundColor(Colors.Tertiary.foreground)
                    .font(.caption)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
        }
        .onTapGesture {
            showShowsList = true
            UIApplication.triggerHapticFeedback()
        }
    }
}




struct ShowsGridView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(GlobalData.shows) { item in
                        ShowGridItemView(item: item)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("Shows", displayMode: .inline)
            .background(Colors.Primary.background)
        }
    }
}
