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
        
        static let babyBlue = Color("PrimaryBabyBlue")
        static let blue = Color("PrimaryBlue")
        static let navy = Color("PrimaryNavy")
        static let green = Color("PrimaryGreen")
        static let yellow = Color("PrimaryYellow")
        static let pink = Color("PrimaryPink")
        static let purple = Color("PrimaryPurple")
        static let mint = Color("PrimaryMint")
        static let orange = Color("PrimaryOrange")
    }
    
    enum Secondary {
        static let accent = Color("SecondaryAccent")
        static let background = Color("SecondaryBackground")
        static let foreground = Color("SecondaryForeground")
        static let divider = Color("SecondaryDivider")
        
        static let babyBlue = Color("SecondaryBabyBlue")
        static let blue = Color("SecondaryBlue")
        static let navy = Color("SecondaryNavy")
        static let green = Color("SecondaryGreen")
        static let yellow = Color("SecondaryYellow")
        static let pink = Color("SecondaryPink")
        //static let purple = Color("SecondaryPurple")
        //static let mint = Color("SecondaryMint")
    }
    
    enum Tertiary {
        static let foreground = Color("TertiaryForeground")
        static let background = Color("TertiaryBackground")
    }
    
}

func getRandomColor() -> Color {
    let colors: [Color] = [
        Colors.Primary.accent,
        Colors.Primary.foreground,
        Colors.Primary.babyBlue,
        Colors.Primary.blue,
        Colors.Primary.green,
        Colors.Primary.yellow,
        Colors.Primary.pink,
        Colors.Primary.mint,
        Colors.Primary.orange,
        Colors.Primary.purple,
        
        Colors.Secondary.accent,
        Colors.Secondary.foreground,
        Colors.Secondary.babyBlue,
        Colors.Secondary.blue,
        Colors.Secondary.green,
        Colors.Secondary.yellow,
        Colors.Secondary.pink
    ]
    
    return colors.randomElement()!
}



func colorForAcronym(_ acronym: String) -> Color {
    switch acronym {
    case "NYFW":
        return Colors.Primary.blue
    case "LFW":
        return Colors.Primary.green
    case "MFW":
        return Colors.Primary.pink
    case "TFW":
        return Colors.Primary.mint
    case "BFW":
        return Colors.Primary.orange
    case "SPFW":
        return Colors.Primary.purple
    case "KFW":
        return Colors.Primary.blue
    case "PFW":
        return Colors.Primary.yellow
    case "SFW":
        return Colors.Primary.babyBlue
    case "JFW":
        return Colors.Primary.accent
    default:
        return Colors.Primary.accent
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
