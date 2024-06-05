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
        static let lightBlue = Color("PrimaryLightBlue")
        static let blue = Color("PrimaryBlue")
        static let darkBlue = Color("PrimaryDarkBlue")
        static let divider = Color("PrimaryDivider")
        static let green = Color("PrimaryGreen")
        static let orange = Color("PrimaryOrange")
        static let pink = Color("PrimaryPink")
    }
    
    enum Secondary {
        static let accent = Color("SecondaryAccent")
        static let background = Color("SecondaryBackground")
        static let foreground = Color("SecondaryForeground")
        static let lightBlue = Color("SecondaryLightBlue")
        static let blue = Color("SecondaryBlue")
        static let darkBlue = Color("SecondaryDarkBlue")
        static let divider = Color("SecondaryDivider")
        static let green = Color("SecondaryGreen")
        static let orange = Color("SecondaryOrange")
        static let pink = Color("SecondaryPink")
    }
    
    enum Tertiary {
        static let foreground = Color("TertiaryForeground")
        static let background = Color("TertiaryBackground")
    }
}





func colorForAcronym(_ acronym: String) -> Color {
    switch acronym {
    case "NYFW":
        return Colors.Primary.blue
    case "LFW":
        return Colors.Primary.green
    case "MFW":
        return Colors.Primary.orange
    case "PFW":
        return Colors.Primary.lightBlue
    case "CFDA":
        return Colors.Primary.darkBlue
    case "MBFW":
        return Colors.Primary.accent
    case "KFW":
        return Colors.Primary.blue
    case "AFW":
        return Colors.Primary.orange
    case "SFW":
        return Colors.Primary.green
    case "JFW":
        return Colors.Primary.accent
    default:
        return Color.primary
    }
}
