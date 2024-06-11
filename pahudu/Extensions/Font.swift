//
//  extensions.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI

extension Font {
    
    static var largeTitle: Font {
        .custom("Geist-Regular", size: 32)
    }
    
    static var title: Font {
        .custom("Geist-Regular", size: 23)
    }
    
    static var headline: Font {
        .custom("Geist-Regular", size: 19)
    }
    
    static var body: Font {
        .custom("Geist-Regular", size: 17)
    }
    
    static var subheadline: Font {
        .custom("Geist-Regular", size: 15)
    }
    
    static var callout: Font {
        .custom("Geist-Regular", size: 15)
    }
    
    static var caption: Font {
        .custom("Geist-Regular", size: 13)
    }
    
    static var footnote: Font {
        .custom("Geist-Regular", size: 11)
    }
    
    
    
    // Custom
    static var button: Font {
        .custom("Geist-Regular", size: 17)
    }
    
    static var numberLarge: Font {
        .custom("Geist-Regular", size: 22)
    }
    
    static var numberMedium: Font {
        .custom("Geist-Regular", size: 16)
    }
    
    static var numberSmall: Font {
        .custom("Geist-Regular", size: 12)
    }
}




extension UIApplication {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
