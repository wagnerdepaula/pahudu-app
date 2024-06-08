//
//  Components.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/6/24.
//

import SwiftUI


struct Divider: View {
    
    var leading: CGFloat = 20
    
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(Colors.Primary.divider)
            .padding(EdgeInsets(top: 0, leading: leading, bottom: 0, trailing: 0))
    }
}
