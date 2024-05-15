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
    case helpSupport = "Help & Support"
    
    var id: String { self.rawValue }
    
    // Associated icon names for each option
    var iconName: String {
        switch self {
        case .myAccount: return "person"
        case .search: return "magnifyingglass"
        case .themes: return "circle.lefthalf.filled"
        case .preferences: return "gearshape"
        case .whatsNew: return "star"
        case .welcome: return "figure.wave"
        case .helpSupport: return "questionmark"
        }
    }
    
    // Associated category for each option
    var category: SettingsCategory {
        switch self {
        case .myAccount, .welcome: return .accountGeneral
        case .search, .whatsNew: return .searchUpdates
        case .themes, .preferences, .helpSupport: return .settingsSupport
        }
    }
}

// Define an enum for your categories
enum SettingsCategory: String, CaseIterable, Identifiable {
    case accountGeneral = "Account & General"
    case searchUpdates = "Search & Updates"
    case settingsSupport = "Settings & Support"
    var id: String { self.rawValue }
}



struct SettingsView: View {
    
    @State private var selectedOption: SettingsOption = .myAccount
    @State private var isPresented: Bool = false
    @State private var pressedStates: [String: Bool] = [:]
    
    var body: some View {
        NavigationStack {
            Spacer(minLength: 20)
            List {
                ForEach(SettingsCategory.allCases, id: \.self) { category in
                    Section {
                        ForEach(SettingsOption.allCases.filter { $0.category == category }, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                isPresented = true
                                UIApplication.triggerHapticFeedback()
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: option.iconName)
                                        .imageScale(.large)
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(.white)
                                    
                                    Text(option.rawValue)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            }
                            .listRowSeparatorTint(Color("DividerColor"))
                            .listRowBackground(Color("SecondaryBackgroundColor"))
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isPresented) {
                switch selectedOption {
                case .myAccount, .search, .themes, .preferences, .whatsNew, .welcome, .helpSupport:
                    DefaultView(text: selectedOption.rawValue)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
            .listSectionSpacing(32)
        }
    }
}




struct DefaultView: View {
    let text: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text(text)
                        .headline()
                        .foregroundColor(.primary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .navigationTitle(text)
            .scrollIndicators(.hidden)
        }
    }
}
