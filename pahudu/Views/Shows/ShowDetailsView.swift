//
//  ShowDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/10/24.
//

import SwiftUI

struct ShowDetailsView: View {
    
    let item: ShowItem
    let width: CGFloat = 300
    let height: CGFloat = 300
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack {
                        Image(item.imageName)
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
                    Text(item.title)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.largeTitle)
                    
                    Text(item.subtitle)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.body)
                    
                    Spacer(minLength: 10)
                    
                    TypedText(text: "New York Fashion Week, held in February and September of each year, is a semi-annual series of events in Manhattan typically spanning seven to nine days when international fashion collections are shown to buyers, the press, and the general public.")
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    UIApplication.triggerHapticFeedback()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Colors.Tertiary.background)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Colors.Primary.accent)
                    }
                }
            }
        }
    }
}
