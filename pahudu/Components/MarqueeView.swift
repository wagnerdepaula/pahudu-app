//
//  Marquee.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/18/24.
//


import SwiftUI

// MarqueeView(message: "PFW: Basic Colour Instinct with Zomer. ")

struct MarqueeView: View {
    
    var message: String
    private let speed: CGFloat = 100.0
    private var marqueeFont: UIFont = UIFont(name: "Inter", size: 15) ?? UIFont.monospacedSystemFont(ofSize: 15, weight: .regular)
    @State private var offset = CGFloat.zero
    
    init(message: String) {
        self.message = message + "" + message + "" + message
    }
    
    var body: some View {
        GeometryReader { geometry in
            Text(message)
                .font(Font(marqueeFont))
                .lineLimit(1)
                .offset(x: offset, y: 0)
                .fixedSize(horizontal: true, vertical: false)
                .onAppear {
                    let messageWidth = (message as NSString).size(withAttributes: [.font: marqueeFont]).width / 3
                    let totalAnimationDistance = messageWidth
                    
                    withAnimation(Animation.linear(duration: Double(totalAnimationDistance) / Double(speed)).repeatForever(autoreverses: false)) {
                        offset = -messageWidth
                    }
                }
        }
        .frame(height: marqueeFont.lineHeight)
        .clipped()
    }
}
