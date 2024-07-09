//
//  AccountView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI

// Define an enum for your options
enum AccountOptions: String, CaseIterable, Identifiable {
    case myAccount = "My Account"
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
        case .preferences: return "gearshape"
        case .helpCenter: return "questionmark"
        case .termsOfUse: return "doc.text"
        case .privacyPolicy: return "lock.shield"
        }
    }
    
    // Associated category for each option
    var category: AccountCategory {
        switch self {
        case .myAccount, .welcome, .whatsNew: return .accountGeneral
        case .preferences: return .appearanceCustomization
        case .helpCenter, .termsOfUse, .privacyPolicy: return .supportLegal
        }
    }
}

// Define an enum for your categories
enum AccountCategory: String, CaseIterable, Identifiable {
    case accountGeneral = "Account & General"
    case appearanceCustomization = "Appearance & Customization"
    case supportLegal = "Support & Legal"
    var id: String { self.rawValue }
}

struct AccountView: View {

    var body: some View {
        NavigationStack {
            List {
                ForEach(AccountCategory.allCases) { category in
                    Section {
                        ForEach(AccountOptions.allCases.filter { $0.category == category }) { option in
                            NavigationLink(destination: destinationView(for: option)) {
                                optionRow(option: option)
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
                .listRowSeparatorTint(Colors.Primary.divider)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Account", displayMode: .inline)
            .background(Colors.Primary.background)
        }
    }
    
    
    private func optionRow(option: AccountOptions) -> some View {
        HStack(spacing: 10) {
            Image(systemName: option.iconName)
                .font(.system(size: 21))
                .frame(width: 35, height: 35)
                .foregroundColor(Colors.Primary.accent)
            Text(option.rawValue)
                .font(.subheadline)
                .foregroundColor(Colors.Primary.foreground)
        }
    }
    
    
    @ViewBuilder
    private func destinationView(for option: AccountOptions) -> some View {
        switch option {
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
        .background(Colors.Primary.background)
        
    }
}
