//
//  Colors.swift
//  pahudu
//
//  Created by Wagner De Paula on 5/27/24.
//

import SwiftUI
import CoreImage

enum Colors {
    
    enum Primary {
        static let accent = Color("PrimaryAccent")
        static let background = Color("PrimaryBackground")
        static let foreground = Color("PrimaryForeground")
        static let divider = Color("PrimaryDivider")
    }
    
    enum Secondary {
        static let accent = Color("SecondaryAccent")
        static let background = Color("SecondaryBackground")
        static let foreground = Color("SecondaryForeground")
        static let divider = Color("SecondaryDivider")
    }
    
    enum Tertiary {
        static let background = Color("TertiaryBackground")
        static let foreground = Color("TertiaryForeground")
    }
    
    enum Quaternary {
        static let background = Color("QuaternaryBackground")
        static let foreground = Color("QuaternaryForeground")
    }
}




extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
