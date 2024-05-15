//
//  ProfileView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//
import SwiftUI


// Define an enum for your options
enum ProfileOption: String, CaseIterable, Identifiable {
    case myAccount = "My Account"
    case search = "Search"
    case calendars = "Calendars"
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
        case .calendars: return "circle.grid.3x3"
        case .themes: return "theatermasks"
        case .preferences: return "gearshape"
        case .whatsNew: return "star"
        case .welcome: return "figure.wave"
        case .helpSupport: return "questionmark"
        }
    }
}


struct ProfileView: View {
    
    @State private var selectedOption: ProfileOption = .myAccount
    @State private var isPresented: Bool = false
    @State private var pressedStates: [String: Bool] = [:]
    
    var body: some View {
        NavigationStack {
            
            List(ProfileOption.allCases, id: \.self) { option in
                
                Button(action: {
                    selectedOption = option
                    isPresented = true
                    UIApplication.triggerHapticFeedback()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: option.iconName)
                            .imageScale(.large)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                        
                        Text(option.rawValue)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .listRowSeparatorTint(Color("DividerColor"))
                .listRowBackground(Color.white.opacity(0.1))
                .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
            //                .scaleEffect(pressedStates[option.id] ?? false ? 0.9 : 1, anchor: .leading)
            //                .opacity(pressedStates[option.id] ?? false ? 0.5 : 1)
            //                .gesture(DragGesture(minimumDistance: 0)
            //                    .onChanged({ _ in
            //                        withAnimation {
            //                            pressedStates[option.id] = true
            //                        }
            //                    })
            //                    .onEnded({ _ in
            //                        withAnimation(.easeOut(duration: 0.1)) {
            //                            pressedStates[option.id] = false
            //                        }
            //                    }))
            
            .navigationDestination(isPresented: $isPresented) {
                switch selectedOption {
                case .myAccount, .search, .calendars, .themes, .preferences, .whatsNew, .welcome, .helpSupport:
                    DefaultView(text: selectedOption.rawValue)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
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
