//
//  SettingsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI

// Define an enum for your options
enum SettingsOption: String, CaseIterable, Identifiable {
    case myAccount = "My Account"
    case search = "Search"
    case themes = "Themes"
    case preferences = "Preferences"
    case whatsNew = "What’s New"
    case welcome = "Welcome"
    case helpCenter = "Help Center"
    case termsOfUse = "Terms of Use"
    case privacyPolicy = "Privacy Policy"
    
    var id: String { self.rawValue }
    
    // Associated icon names for each option
    var iconName: String {
        switch self {
        case .myAccount: return "person"
        case .welcome: return "hand.wave"
        case .whatsNew: return "star"
        case .search: return "magnifyingglass"
        case .themes: return "circle.lefthalf.filled"
        case .preferences: return "gearshape"
        case .helpCenter: return "questionmark"
        case .termsOfUse: return "doc.text"
        case .privacyPolicy: return "lock.shield"
        }
    }
    
    // Associated category for each option
    var category: SettingsCategory {
        switch self {
        case .myAccount, .welcome, .whatsNew, .search: return .accountGeneral
        case .themes, .preferences: return .appearanceCustomization
        case .helpCenter, .termsOfUse, .privacyPolicy: return .supportLegal
        }
    }
}

// Define an enum for your categories
enum SettingsCategory: String, CaseIterable, Identifiable {
    case accountGeneral = "Account & General"
    case appearanceCustomization = "Appearance & Customization"
    case supportLegal = "Support & Legal"
    var id: String { self.rawValue }
}


struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(SettingsCategory.allCases) { category in
                    Section {
                        ForEach(SettingsOption.allCases.filter { $0.category == category }) { option in
                            NavigationLink(destination: {
                                switch option {
                                case .search:
                                    SearchView()
                                default:
                                    DefaultView(text: option.rawValue)
                                }
                            }) {
                                Label {
                                    Text(option.rawValue)
                                        .font(.button)
                                } icon: {
                                    Image(systemName: option.iconName)
                                        .fontWeight(.light)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct DefaultView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .navigationBarTitle(text, displayMode: .inline)
    }
}
