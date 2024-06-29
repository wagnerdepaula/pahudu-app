//
//  Divider.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/22/24.
//

import SwiftUI

struct Divider: View {
    
    var padding: CGFloat = 0
    var height: CGFloat = 0.5
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(Colors.Primary.divider)
            .padding(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
    }
}
