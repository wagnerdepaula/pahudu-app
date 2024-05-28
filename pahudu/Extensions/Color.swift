//
//  Colors.swift
//  pahudu
//
//  Created by Wagner De Paula on 5/27/24.
//
import SwiftUI

func colorForAcronym(_ acronym: String) -> Color {
        switch acronym {
        case "NYFW":
            return Color("PrimaryBlue")
        case "LFW":
            return Color("PrimaryGreen")
        case "MFW":
            return Color("PrimaryRed")
        case "PFW":
            return Color("PrimaryTaupe")
        case "CFDA":
            return Color("SecondaryBlue")
        case "MBFW":
            return Color("SecondaryGreen")
        case "KFW":
            return Color("SecondaryRed")
        case "AFW":
            return Color("SecondaryTaupe")
        case "SFW":
            return Color("PrimaryBlue")
        case "JFW":
            return Color("PrimaryGreen")
        default:
            return Color.primary
        }
    }
