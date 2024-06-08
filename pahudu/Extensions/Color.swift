//
//  Colors.swift
//  pahudu
//
//  Created by Wagner De Paula on 5/27/24.
//
import SwiftUI


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
        static let purple = Color("SecondaryPurple")
        static let mint = Color("SecondaryMint")
    }
    
    enum Tertiary {
        static let foreground = Color("TertiaryForeground")
        static let background = Color("TertiaryBackground")
    }
}

func getRandomColor() -> Color {
    let colors: [Color] = [
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
        return Colors.Primary.navy
    case "LFW":
        return Colors.Primary.green
    case "MFW":
        return Colors.Primary.pink
    case "PFW":
        return Colors.Primary.mint
    case "CFDA":
        return Colors.Primary.orange
    case "MBFW":
        return Colors.Primary.purple
    case "KFW":
        return Colors.Primary.blue
    case "AFW":
        return Colors.Primary.yellow
    case "SFW":
        return Colors.Primary.babyBlue
    case "JFW":
        return Colors.Primary.accent
    default:
        return Colors.Primary.accent
    }
}
