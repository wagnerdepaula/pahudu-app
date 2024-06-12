//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct DesignerDetailsView: View {
    
    @ObservedObject var motionManager = MotionManager()
    let item: DesignerItem
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 260, height: max(260, 260 + offsetY))
                            .offset(x: motionManager.roll * 15, y: 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 350, alignment: .bottom)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .frame(height: 350)
                
                
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
        .onAppear {
            motionManager.startMonitoringMotionUpdates()
        }
        .onDisappear {
            motionManager.stopMonitoringMotionUpdates()
        }
    }
}