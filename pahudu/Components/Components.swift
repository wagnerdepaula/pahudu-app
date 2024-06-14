//
//  Components.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/6/24.
//

import SwiftUI


struct Divider: View {
    var leading: CGFloat = 0
    
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(Colors.Primary.divider)
            .padding(EdgeInsets(top: 0, leading: leading, bottom: 0, trailing: 0))
    }
}




struct TypedText: View {
    
    let text: String
    @State private var displayedText = ""
    @State private var wordIndex = 0
    private let typingSpeed = 0.02
    private var words: [String] {
        text.split(separator: " ").map(String.init)
    }

    var body: some View {
        Text(displayedText)
            .fixedSize(horizontal: false, vertical: true)
            .onReceive(Timer.publish(every: typingSpeed, on: .main, in: .common).autoconnect()) { _ in
                if wordIndex < words.count {
                    displayedText += (displayedText.isEmpty ? "" : " ") + words[wordIndex]
                    wordIndex += 1
                    
                    if (wordIndex % 4 == 0) {
                        UIApplication.triggerHapticFeedback(style: .soft)
                    }
                }
            }
    }
}





