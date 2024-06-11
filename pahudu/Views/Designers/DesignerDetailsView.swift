//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI


struct DesignerDetailsView: View {
    
    let item: DesignerItem
    @ObservedObject var motionManager = MotionManager()
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 20) {
                
                ZStack {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300, maxHeight: 300)
                        .offset(x: motionManager.roll * 15, y: 0)
                }
                .frame(maxWidth: .infinity, minHeight: 350, alignment: .bottom)
                .padding(0)
                .background(Colors.Secondary.foreground)
                
                DesignerInfoView(title: item.title, subtitle: item.subtitle)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.vertical, 0)
            .padding(.horizontal, 0)
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



struct DesignerInfoView: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(Colors.Primary.foreground)
                .font(.largeTitle)
            
            Text(subtitle)
                .foregroundColor(Colors.Tertiary.foreground)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

