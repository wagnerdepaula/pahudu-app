//
//  extensions.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI

extension Font {
    
    static var largeTitle: Font {
        .custom("Geist-Regular", size: 34)
    }
    
    static var title: Font {
        .custom("Geist-Regular", size: 22)
    }
    
    static var headline: Font {
        .custom("Geist-Regular", size: 18)
    }
    
    static var body: Font {
        .custom("Geist-Regular", size: 16)
    }
    
    static var subheadline: Font {
        .custom("Geist-Medium", size: 16)
    }
    
    static var callout: Font {
        .custom("Geist-Regular", size: 14)
    }
    
    static var caption: Font {
        .custom("Geist-Medium", size: 12)
    }
    
    
    // Custom
    static var button: Font {
        .custom("Geist-Regular", size: 16)
    }
    
    static var numberLarge: Font {
        .custom("Geist-Medium", size: 22)
    }
    
    static var numberMedium: Font {
        .custom("Geist-Regular", size: 16)
    }
    
    static var numberSmall: Font {
        .custom("GeistMono-Regular", size: 12)
    }
}




extension UIApplication {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
