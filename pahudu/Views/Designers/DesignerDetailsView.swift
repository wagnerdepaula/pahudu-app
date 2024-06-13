//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct DesignerDetailsView: View {
    
    let item: DesignerItem
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: max(width, width + offsetY))
                    }
                    .frame(maxWidth: .infinity, maxHeight: width, alignment: .bottom)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                    )

                }
                .frame(height: width)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.largeTitle)
                    
                    Text(item.subtitle)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                    
                Spacer()
   
                
            }
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .edgesIgnoringSafeArea(.all)
        .scrollContentBackground(.hidden)
        .background(Colors.Primary.background)
    }
}
