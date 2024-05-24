//
//  extensions.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


extension Text {
    
    func largeTitle() -> some View {
        self
            .font(.custom("Geist-Regular", size: 34))
            .kerning(0.3)
    }
    
    func title() -> some View {
        self
            .font(.custom("Geist-Regular", size: 22))
            .kerning(0.3)
    }
    
    func headline() -> some View {
        self
            .font(.custom("Geist-Regular", size: 18))
            .lineSpacing(5)
            .kerning(0.3)
    }
    
    func body() -> some View {
        self
            .font(.custom("Geist-Regular", size: 16))
            .lineSpacing(5)
            .kerning(0.3)
    }
    
    func callout() -> some View {
        self
            .font(.custom("Geist-Medium", size: 16))
            .lineSpacing(5)
            .kerning(0.3)
    }
    
    func subheadline() -> some View {
        self
            .font(.custom("Geist-Medium", size: 16))
            .lineSpacing(5)
            .kerning(0.3)
    }
    
    func caption() -> some View {
        self
            .font(.custom("Geist-Medium", size: 12))
            .lineSpacing(5)
            .kerning(0.3)
    }
    
    
    
    
    // Custom
    
    func button() -> some View {
        self
            .font(.custom("Geist-Regular", size: 16))
            .kerning(0.3)
            .lineSpacing(0)
    }
    
    
    func numberLarge() -> some View {
        self
            .font(.custom("GeistMono-Bold", size: 22))
            .kerning(0.3)
            .lineSpacing(0)
    }
    
    func numberMedium() -> some View {
        self
            .font(.custom("GeistMono-Medium", size: 16))
            .kerning(0.5)
            .lineSpacing(0)
            .multilineTextAlignment(.center)
    }
    
    func numberSmall() -> some View {
        self
            .font(.custom("GeistMono-Regular", size: 12))
            .kerning(0.5)
            .lineSpacing(0)
            .multilineTextAlignment(.center)
    }
    
}



extension UIApplication {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
