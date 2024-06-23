//
//  Theme.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/23/24.
//

import SwiftUI


enum ThemeOption: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}


struct ThemeModifier: ViewModifier {
    @AppStorage("selectedTheme") var selectedTheme: ThemeOption = .system
    @Environment(\.colorScheme) var systemColorScheme

    func body(content: Content) -> some View {
        content
            .preferredColorScheme(colorScheme)
    }

    private var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
