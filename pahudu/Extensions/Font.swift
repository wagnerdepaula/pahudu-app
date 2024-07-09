//
//  extensions.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI

extension Font {
    
    static var largeTitle: Font {
        .custom("Inter-Regular", size: 35)
    }
    
    static var title1: Font {
        .custom("Inter-Regular", size: 24)
    }
    
    static var title2: Font {
        .custom("Inter-Regular", size: 22)
    }
    
    static var title3: Font {
        .custom("Inter-Medium", size: 20)
    }
    
    static var headline: Font {
        .custom("Inter-Regular", size: 18)
    }
    
    static var subheadline: Font {
        .custom("Inter-Regular", size: 16)
    }
    
    static var body: Font {
        .custom("Inter-Regular", size: 15)
    }
    
    static var callout: Font {
        .custom("Inter-Regular", size: 14)
    }
    
    static var caption: Font {
        .custom("Inter-Regular", size: 13)
    }
    
    static var footnote: Font {
        .custom("Inter-Regular", size: 11)
    }
    
    
    
    // Custom
   
    static var numberLarge: Font {
        .custom("Inter-Regular", size: 22)
    }
    
    static var numberMedium: Font {
        .custom("Inter-Regular", size: 16)
    }
    
    static var numberSmall: Font {
        .custom("Inter-Regular", size: 11)
    }
    
    static var button: Font {
        .custom("Inter-Medium", size: 16)
    }
    
}



// Extension to apply font features
extension View {
    func fontFeatures(_ features: [[UIFontDescriptor.FeatureKey: Any]]) -> some View {
        self.modifier(FontFeatureModifier(features: features))
    }
}

// Font feature modifier
struct FontFeatureModifier: ViewModifier {
    let features: [[UIFontDescriptor.FeatureKey: Any]]

    func body(content: Content) -> some View {
        content.environment(\.font, customFont)
    }

    private var customFont: Font {
        let descriptor = UIFontDescriptor(name: "Inter-Regular", size: 14).addingAttributes([
            .featureSettings: features
        ])
        return Font(UIFont(descriptor: descriptor, size: 14))
    }
}
