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
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 34))
//            .font(.system(size: 34))
            .kerning(0.2)
    }
    
    func title() -> some View {
        self
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 22))
//            .font(.system(size: 22))
            .kerning(0.2)
    }
    
    func headline() -> some View {
        self
            .fontWeight(.medium)
            .font(.custom("SuisseBPIntl-Medium", size: 18))
//            .font(.system(size: 17))
            .lineSpacing(5)
            .kerning(0.2)
    }
    
    func body() -> some View {
        self
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 18))
//            .font(.system(size: 17))
            .lineSpacing(5)
            .kerning(0.2)
    }
    
    func callout() -> some View {
        self
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 18))
//            .font(.system(size: 16))
            .lineSpacing(5)
            .kerning(0.2)
    }
    
    func subheadline() -> some View {
        self
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 16))
//            .font(.system(size: 15))
            .lineSpacing(5)
            .kerning(0.2)
    }
    
    func caption() -> some View {
        self
            .fontWeight(.regular)
            .font(.custom("SuisseBPIntl-Medium", size: 12))
//            .font(.system(size: 12))
            .lineSpacing(5)
            .kerning(0.2)
    }
    
    
    
    
// Custom
    
    func button() -> some View {
        self
            .fontWeight(.regular)
//            .font(.system(size: 16, weight: .medium))
            .font(.custom("SuisseBPIntl-Medium", size: 16))
            .kerning(0.2)
            .lineSpacing(0)
    }
    
    
    func numberLarge() -> some View {
        self
            .fontWeight(.medium)
//            .font(.system(size: 22, design: .monospaced))
            .font(.custom("SuisseBPIntl-Medium", size: 28))
            .kerning(0.2)
            .lineSpacing(0)
    }
    
    func numberSmall() -> some View {
        self
            .fontWeight(.medium)
//            .font(.system(size: 16, design: .monospaced))
            .font(.custom("SuisseBPIntl-Medium", size: 18))
            .kerning(0.2)
            .lineSpacing(0)
    }
    
}



extension UIApplication {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
