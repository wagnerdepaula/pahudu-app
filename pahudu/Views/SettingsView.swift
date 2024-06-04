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
        case .preferences: return "gear"
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
                            NavigationLink(destination: destinationView(for: option)) {
                                HStack(spacing: 10) {
                                    Image(systemName: option.iconName)
                                        .font(.system(size: 20))
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(Color("PrimaryAccent"))
                                    Text(option.rawValue)
                                        .font(.button)
                                        .foregroundColor(Color("PrimaryText"))
                                }
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15))
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("PrimaryBackground"))
        }
    }
    
    @ViewBuilder
    private func destinationView(for option: SettingsOption) -> some View {
        switch option {
        case .search:
            SearchView()
        default:
            DefaultView(text: option.rawValue)
        }
    }
}

struct DefaultView: View {
    let text: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Text(text)
                    .navigationTitle(text)

            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        .background(Color("PrimaryBackground"))
        
    }
}
