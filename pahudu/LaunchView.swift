//
//  LaunchView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/23/24.
//

import SwiftUI


struct LaunchView: View {
    
    var body: some View {
        
        ZStack (alignment: .center) {
            
            Colors.Primary.background
                .ignoresSafeArea(.all)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
        }
    }
}

