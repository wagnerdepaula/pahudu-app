//
//  Title.swift
//  pahudu
//
//  Created by Wagner De Paula on 7/2/24.
//

import SwiftUI

struct Title: View {
    
    var text: String = ""
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .foregroundColor(Colors.Primary.foreground)
                .font(.title3)
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        
    }
}

