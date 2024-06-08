//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI


struct DesignerDetailsView: View {
    
    let item: DesignerItem
    let color: Color = getRandomColor()
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 20) {
                
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Colors.Secondary.foreground)
                    .clipShape(Circle())
                
                VStack(alignment: .center, spacing: 5) {
                    Text(item.title)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                    
                    Text(item.subtitle)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.caption)
                }
                .padding(.leading, 8)
                
                
                
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .scrollContentBackground(.hidden)
        .background(
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .blur(radius: 100)
                .opacity(0.3)
        )
        .background(Colors.Primary.background)
    }
    
    
}



