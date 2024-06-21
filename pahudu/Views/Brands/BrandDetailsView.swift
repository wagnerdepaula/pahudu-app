//
//  BrandDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/8/24.
//

import SwiftUI


struct BrandDetailsView: View {
    
    let item: Brand
    let width: CGFloat = 300
    let height: CGFloat = 300
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack {
                        Image(item.name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Colors.Primary.foreground)
                            .frame(width: 260, height: max(260, 260 + offsetY))
                    }
                    .frame(maxWidth: .infinity, maxHeight: height, alignment: .bottom)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .frame(height: height)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.name)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.largeTitle)
                    
                    Text(item.nationality)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.body)
                    
                    Spacer(minLength: 10)
                    
                    TypedText(text: item.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
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
